`timescale 1ns/1ns
module vending_machine_refund_tb();

    reg sys_clk;
    reg sys_rst_n;
    reg pi_money_one;
    reg pi_money_half;
    reg pi_refund;
    reg random_data_gen;

    wire po_cola;
    wire po_money;

    initial begin
        sys_clk = 1'b1;
        sys_rst_n = 1'b0;
        #20 sys_rst_n = 1'b1;
    end

    always #10 sys_clk = ~sys_clk;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            random_data_gen <= 1'b0;
        else
            random_data_gen <= {$random} % 2;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            pi_money_one <= 1'b0;
        else
            pi_money_one <= random_data_gen;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            pi_money_half <= 1'b0;
        else
            pi_money_half <= ~random_data_gen;

    always @(posedge sys_clk or negedge sys_rst_n)
        if (sys_rst_n == 1'b0)
            pi_refund <= 1'b0;
        else
            pi_refund <= ($random % 10) < 2 ? 1'b1 : 1'b0; 

    wire [4:0] state = vending_machine_refund_inst.state;
    wire [1:0] pi_money = vending_machine_refund_inst.pi_money;

    initial begin
        $timeformat(-9, 0, "ns", 6);
        $monitor("@time %t: pi_money_one=%b, pi_money_half=%b, pi_money=%b, state=%b, po_cola=%b, po_money=%b, pi_refund=%b", 
                 $time, pi_money_one, pi_money_half, pi_money, state, po_cola, po_money, pi_refund);
    end

    vending_machine_refund vending_machine_refund_inst (
        .sys_clk (sys_clk),
        .sys_rst_n (sys_rst_n),
        .pi_money_one (pi_money_one),
        .pi_money_half (pi_money_half),
        .pi_refund (pi_refund), 

        .po_cola (po_cola),
        .po_money (po_money)
    );

endmodule




