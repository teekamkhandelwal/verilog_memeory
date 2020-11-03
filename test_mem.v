// Code your testbench here
// or browse Examples
module top;
  localparam P_MEM_DW = 8;
  localparam P_MEM_AW = 5;
  
  //inputs and outputs
  logic clk;
  logic m_cs;
  logic m_rw;
  logic [P_MEM_AW-1:0] m_addr;
  logic [P_MEM_DW-1:0] m_wdata;
  logic [P_MEM_DW-1:0] m_rdata;
  mem_mdl#(P_MEM_DW,P_MEM_AW) md(clk, m_cs, m_rw, m_addr, m_wdata,m_rdata);
  
  // conditions of verificatiions
  //clk generator
  initial begin
    clk=1'b0;
    forever 
      #10 clk=~clk;
  end
  
  //various inputs
  initial begin
    //intialization
    
    m_cs = 1'b0; m_rw = 1'b0; 
    repeat(5) @(posedge clk);
    m_cs = 1'b1; m_rw=1'b0; m_addr=5'h07; m_wdata=8'hab;
    repeat(5) @(posedge clk);
    m_cs = 1'b0; m_rw=1'b0; m_addr=5'hxx; m_wdata=8'h00;
    repeat(5) @(posedge clk);
    m_cs=1'b1; m_rw=1'b1; m_addr=5'h07;
    m_cs = 1'b0; m_rw=1'b0; m_addr=5'hxx; m_wdata=8'h00;
    repeat(5) @(posedge clk);
   #100 $finish;
  end
    
    //monitor  
   /* initial begin
      if(m_cs) begin
        if(m_rw)
          $monitor("time %t : Read :: r_data=%2h, adress= %2d ",$time,m_rdata,m_addr);
        else
          $monitor("time %t : write :: w_data=%2h, adress= %2d ",$time,m_wdata,m_addr);
      end
    end*/
  initial begin 
    $dumpfile("top.vcd");
    $dumpvars(0,top);
  end
 
  endmodule
    
