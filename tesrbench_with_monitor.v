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
 // initial begin
    //intialization
    
  /*  m_cs = 1'b0; m_rw = 1'b0; 
    repeat(5) @(posedge clk);
    m_cs = 1'b1; m_rw=1'b0; m_addr=5'h07; m_wdata=8'hab;
    repeat(5) @(posedge clk);
    m_cs = 1'b0; m_rw=1'b0; m_addr=5'hxx; m_wdata=8'h00;
    repeat(5) @(posedge clk);
    m_cs=1'b1; m_rw=1'b1; m_addr=5'h07;
    m_cs = 1'b0; m_rw=1'b0; m_addr=5'hxx; m_wdata=8'h00;
    repeat(5) @(posedge clk);
   #100 $finish;
  end*/
    
    
    //driver
    task mem_control_init;
      begin
        m_cs=1'b0;
        m_rw=1'b0;
      end
    endtask
      task mem_write;
        input [P_MEM_AW-1:0] addr;
        input[P_MEM_DW-1:0] wdata;
        begin
          m_cs=1'b1;
          m_rw=1'b0;
          m_addr=addr;
          m_wdata=wdata;
          repeat(1) @(posedge clk);
          m_cs=1'b0;
          m_rw=1'b0;
          m_addr=5'hxx;
          m_wdata=8'hxx;
        end
        
      endtask
  
      task mem_read ;
        input [P_MEM_AW-1:0] addr;
        begin
          m_cs=1'b1;
          m_rw=1'b1;
          m_addr=addr;
         
          repeat(5)@(posedge clk);
          m_cs = 1'b0;
          m_rw=1'b0;
          m_addr=5'hxx;
        end
      endtask
      
      
      
    
    //monitor  
  always@(posedge clk) begin

      if(m_cs) begin
        if(m_rw)
          $display("time %t : Read :: r_data=%2h, adress= %2d ",$time,m_rdata,m_addr);
        else
          $display("time %t : write :: w_data=%2h, adress= %2d ",$time,m_wdata,m_addr);
      end
    end
  initial begin
        mem_control_init();
        repeat(5)@(posedge clk);
        mem_write(5'h07,8'hab);
        repeat(5) @(posedge clk);
        mem_read(5'h07);
        repeat(5)@(posedge clk);
        $finish;
      end
    
  initial begin 
    $dumpfile("top.vcd");
    $dumpvars(0,top);
  end
 
  endmodule
    
//output-
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: time                  110 : write :: w_data=ab, adress=  7 
# KERNEL: time                  230 : Read :: r_data=ab, adress=  7 
# KERNEL: time                  250 : Read :: r_data=ab, adress=  7 
# KERNEL: time                  270 : Read :: r_data=ab, adress=  7 
# KERNEL: time                  290 : Read :: r_data=ab, adress=  7 
# KERNEL: time                  310 : Read :: r_data=ab, adress=  7 
