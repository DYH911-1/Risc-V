`timescale 1ns / 1ps


module tb_riscv_tests;

    //--------------------------------------------------------------------------
    // 【配置区】你只需要修改这里
    //--------------------------------------------------------------------------
    parameter TEST_FILE     = "F:/Risc-V/inst_txt/rv32ui-p-sw.txt"; // 你的测试文件名
    parameter CLK_PERIOD    = 20;       // 时钟周期：50MHz
    parameter TOHOST_ADDR   = 32'h1040; // ToHost地址
    parameter TIMEOUT_NS    = 50_000_000; // 超时时间
    parameter RST_POLARITY  = 1;        // 复位极性：0=低电平复位，1=高电平复位

    // 【关键】修改这里的寄存器堆层次路径，匹配你的CPU
    // 示例路径：u_myCPU.u_top_riscv.regs_inst.regs
    `define REGS_PATH u_myCPU.u_top_riscv.regs_inst.regs

    //--------------------------------------------------------------------------
    // 信号定义
    //--------------------------------------------------------------------------
    logic        cpu_clk;
    logic        cpu_rst;
    logic [31:0] irom_addr, irom_data;
    logic [31:0] perip_addr, perip_wdata, perip_rdata;
    logic        perip_wen;
    logic [1:0]  perip_mask;

    // 直接访问寄存器
    wire [31:0] x3  = `REGS_PATH[3];   // 失败编号
    wire [31:0] x26 = `REGS_PATH[26];  // 测试完成标志
    wire [31:0] x27 = `REGS_PATH[27];  // 测试通过标志

    //--------------------------------------------------------------------------
    // 例化你的CPU
    //--------------------------------------------------------------------------
    myCPU u_myCPU (
        .cpu_rst      (cpu_rst),
        .cpu_clk      (cpu_clk),
        .irom_addr    (irom_addr),
        .irom_data    (irom_data),
        .perip_addr   (perip_addr),
        .perip_wen    (perip_wen),
        .perip_mask   (perip_mask),
        .perip_wdata  (perip_wdata),
        .perip_rdata  (perip_rdata)
    );

    //--------------------------------------------------------------------------
    // 存储器
    //--------------------------------------------------------------------------
    logic [31:0] irom [0:8191] = '{default: 32'h00000013};
    logic [31:0] dram [0:8191] = '{default: 32'h0};

    //--------------------------------------------------------------------------
    // 时钟生成
    //--------------------------------------------------------------------------
    initial begin
        cpu_clk = 0;
        forever #(CLK_PERIOD/2) cpu_clk = ~cpu_clk;
    end

    //--------------------------------------------------------------------------
    // 复位生成（支持高低电平配置）
    //--------------------------------------------------------------------------
    initial begin
        if (RST_POLARITY == 0) begin
            // 低电平复位：先0后1
            cpu_rst = 0;
            #(CLK_PERIOD * 3);
            cpu_rst = 1;
        end else begin
            // 高电平复位：先1后0
            cpu_rst = 1;
            #(CLK_PERIOD * 3);
            cpu_rst = 0;
        end
    end

    //--------------------------------------------------------------------------
    // 存储器读写
    //--------------------------------------------------------------------------
    assign irom_data = irom[irom_addr[31:2]];
    assign perip_rdata = dram[perip_addr[31:2]];

    // 【关键修复】根据 perip_addr[1:0] 来判断写哪个字节/半字
    always_ff @(posedge cpu_clk) begin
        if (perip_wen) begin
            case (perip_mask)
                2'b00: begin // SB：根据地址偏移写对应字节
                    case(perip_addr[1:0])
                        2'b00: dram[perip_addr[31:2]][7:0]   <= perip_wdata[7:0];
                        2'b01: dram[perip_addr[31:2]][15:8]  <= perip_wdata[15:8];
                        2'b10: dram[perip_addr[31:2]][23:16] <= perip_wdata[23:16];
                        2'b11: dram[perip_addr[31:2]][31:24] <= perip_wdata[31:24];
                    endcase
                end
                2'b01: begin // SH：根据地址偏移写对应半字
                    case(perip_addr[1])
                        1'b0: dram[perip_addr[31:2]][15:0]  <= perip_wdata[15:0];
                        1'b1: dram[perip_addr[31:2]][31:16] <= perip_wdata[31:16];
                    endcase
                end
                2'b10: begin // SW：写整个32位
                    dram[perip_addr[31:2]] <= perip_wdata;
                end
            endcase
        end
    end

    //--------------------------------------------------------------------------
    // 核心：自动测试逻辑（融合两种判断方式）
    //--------------------------------------------------------------------------
    initial begin
        $display("========================================");
        $display("begin test: %s", TEST_FILE);
        $display("========================================");

        // 加载测试程序
        $readmemh(TEST_FILE, irom);
        $display("all test data loaded into IROM.");
        $readmemh(TEST_FILE, dram);
        $display("all test data loaded into DRAM.");

        // 等待复位释放
        if (RST_POLARITY == 0) wait(cpu_rst);
        else wait(!cpu_rst);
        $display("cpu is running...");
        $display("----------------------------------------");

        // 并行监测
        fork
            // 方式1：监测ToHost地址写操作（推荐）
            begin
                forever begin
                    @(posedge cpu_clk);
                    if (perip_wen && perip_addr == TOHOST_ADDR) begin
                        print_result(perip_wdata);
                        $stop;
                    end
                end
            end

            // 方式2：直接监测寄存器（借鉴你的写法，备选）
            begin
                wait(x26 == 1);
                #200;
                if (x27 == 1) begin
                    print_result(1);
                end else begin
                    print_result(x3);
                end
                $stop;
            end

            // 超时保护
            begin
                #(TIMEOUT_NS);
                $display("----------------------------------------");
                $display("error 【%s】 test timeout!", TEST_FILE);
                $display("========================================");
                $stop;
            end
        join
    end

    //--------------------------------------------------------------------------
    // 辅助任务：打印结果和所有寄存器（借鉴你的写法）
    //--------------------------------------------------------------------------
    task print_result(input [31:0] result);
        integer r;
        $display("----------------------------------------");
        if (result == 1) begin
            $display("############################");
            $display("########  pass  !!!#########");
            $display("############################");
        end else begin
            $display("############################");
            $display("########  fail  !!!#########");
            $display("############################");
            $display("fail testnum = %2d", result);
            $display("----------------------------------------");
            $display("all register values:");
            for(r = 0; r < 32; r = r + 1) begin
                $display("x%2d = 0x%08h (%0d)", r, `REGS_PATH[r], `REGS_PATH[r]);
            end
        end
        $display("========================================");
    endtask

endmodule