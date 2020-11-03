// Code your design here
module mem_mdl#(parameter P_MEM_DW = 32,
               
                parameter  P_MEM_AW = 16)(
  input clk,
  input m_cs,
  input m_rw,
  input [P_MEM_AW-1:0] m_addr,
  input [P_MEM_DW-1:0] m_wdata,
  input [P_MEM_DW-1:0] m_rdata );
  
  
  logic [P_MEM_DW-1:0] mem [(1<<P_MEM_AW)-1:0];
  always@(posedge clk) begin
    if(m_cs & ~m_rw)
      mem[m_addr]<=m_wdata;
  end
  
  
  assign m_rdata = m_cs & m_rw ? mem[m_addr] : {P_MEM_DW{1'h0}};
endmodule
