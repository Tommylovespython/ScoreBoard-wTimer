module clock_divider(
  input clk,
  input reset,
  output reg sclk
);

  reg [31:0] count;
  
  always @(posedge clk or negedge reset) begin
    if (reset == 1'b0) begin
      count <= 32'd0;
      sclk <= 1'b0;
    end else begin
      if (count == 32'd49999999) begin
        count <= 32'd0;
        sclk <= ~sclk;
      end else begin
        count <= count + 1;
      end
    end
  end
  
  always @(posedge clk) begin
    $display("count = %d, sclk = %b", count, sclk);
  end
  
endmodule


module tb_clock_divider;
  reg clk;
  reg reset;
  wire sclk;
  
  clock_divider dut(.clk(clk), .reset(reset), .sclk(sclk));
  
  initial begin
    clk = 0;
    reset = 1;
    
    #10 reset = 0;
    
    #100 $finish;
  end
  
  always #5 clk = ~clk;
endmodule
