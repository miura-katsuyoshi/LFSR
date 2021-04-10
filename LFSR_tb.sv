`include "vunit_defines.svh"

`define CUT CUT

module LFSR%WIDTH%_tb;
    parameter WIDTH = %WIDTH%;

    logic clk;
    logic n_rst;
    logic [WIDTH-1:0] out;

    default clocking cb @(posedge clk);
    endclocking

    `TEST_SUITE begin

        `TEST_SUITE_SETUP begin
        end

        `TEST_CASE_SETUP begin
            clk = 1'b1;
            n_rst = 1'b0;
            ##5 n_rst <= ~n_rst;
        end

        `TEST_CASE("repetition_period_test") begin
            `CHECK_EQUAL(`CUT.out, '1);
            repeat((2**WIDTH)-2) ##1 `CHECK_NOT_EQUAL(`CUT.out, '1);
            ##1 `CHECK_EQUAL(`CUT.out, '1);
        end

        `TEST_CASE_CLEANUP begin
        end

        `TEST_SUITE_CLEANUP begin
        end
    end;

    //   `WATCHDOG(1us);

    LFSR #(
        .WIDTH(WIDTH)
    )
    `CUT (
        .clk(clk),
        .n_rst(n_rst),
        .out(out)
    );

    always #5 clk = ~clk;

endmodule
