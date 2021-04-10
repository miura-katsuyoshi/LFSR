module LFSR #(
    parameter WIDTH = 16
) (
    input logic clk,
    input logic n_rst,
    output logic [WIDTH-1:0] out
);
    localparam int tap[5:64][3] = '{
        '{3, 2, 1},  // 5
        '{4, 2, 1},  // 6
        '{5, 4, 3},  // 7
        '{5, 4, 3},  // 8
        '{7, 5, 4},  // 9
        '{8, 6, 5},  // 10
        '{9, 8, 6},  // 11
        '{10, 7, 5},  // 12
        '{11, 9, 8},  // 13
        '{12, 10, 8},  // 14
        '{13, 12, 10},  // 15
        '{13, 12, 10},  // 16
        '{15, 14, 13},  // 17
        '{16, 15, 12},  // 18
        '{17, 16, 13},  // 19
        '{18, 15, 13},  // 20
        '{19, 18, 15},  // 21
        '{18, 17, 16},  // 22
        '{21, 19, 17},  // 23
        '{22, 20, 19},  // 24
        '{23, 22, 21},  // 25
        '{24, 23, 19},  // 26
        '{25, 24, 21},  // 27
        '{26, 23, 21},  // 28
        '{27, 26, 24},  // 29
        '{28, 25, 23},  // 30
        '{29, 28, 27},  // 31
        '{29, 25, 24},  // 32
        '{31, 28, 26},  // 33
        '{30, 29, 25},  // 34
        '{33, 27, 26},  // 35
        '{34, 28, 27},  // 36
        '{35, 32, 30},  // 37
        '{36, 32, 31},  // 38
        '{37, 34, 31},  // 39
        '{36, 35, 34},  // 40
        '{39, 38, 37},  // 41
        '{39, 36, 34},  // 42
        '{41, 37, 36},  // 43
        '{41, 38, 37},  // 44
        '{43, 41, 40},  // 45
        '{39, 38, 37},  // 46
        '{45, 42, 41},  // 47
        '{43, 40, 38},  // 48
        '{44, 43, 42},  // 49
        '{47, 46, 45},  // 50
        '{49, 47, 44},  // 51
        '{50, 48, 45},  // 52
        '{51, 50, 46},  // 53
        '{50, 47, 45},  // 54
        '{53, 52, 48},  // 55
        '{53, 51, 48},  // 56
        '{54, 53, 51},  // 57
        '{56, 52, 51},  // 58
        '{56, 54, 51},  // 59
        '{57, 55, 54},  // 60
        '{59, 58, 55},  // 61
        '{58, 56, 55},  // 62
        '{61, 58, 57},  // 63
        '{62, 60, 59}   // 64
    };

    logic [WIDTH-1:0] LFSR_out = '1;
    logic [WIDTH-1:0] LFSR_in;

    always_ff @(posedge clk) begin
        if(~n_rst) LFSR_out <= '1;
        else LFSR_out <= LFSR_in;
    end
    assign out = LFSR_out;

    generate
        genvar i;
        for(i=0; i<WIDTH-1; i++) begin: LFSR
            if(tap[WIDTH][0]==i || tap[WIDTH][1]==i || tap[WIDTH][2]==i)
                assign LFSR_in[i] = LFSR_out[i+1] ^ LFSR_out[0];
            else
                assign LFSR_in[i] = LFSR_out[i+1];
        end        
    endgenerate
    assign LFSR_in[WIDTH-1] = LFSR_out[0];

endmodule
