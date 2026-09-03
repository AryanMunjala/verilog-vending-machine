`timescale 1ns/1ps

module vending_machine_tb;

reg clk;
reg rst;
reg start;
reg [1:0] select;
reg coin5;
reg coin10;
reg coin20;
reg online_pay;
reg cancel;

wire dispense;
wire success;
wire failure;
wire refund;
wire [5:0] change;

vending_machine uut(
    .clk(clk),
    .rst(rst),
    .start(start),
    .select(select),
    .coin5(coin5),
    .coin10(coin10),
    .coin20(coin20),
    .online_pay(online_pay),
    .cancel(cancel),
    .dispense(dispense),
    .success(success),
    .failure(failure),
    .refund(refund),
    .change(change)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    start = 0;
    select = 2'b00;
    coin5 = 0;
    coin10 = 0;
    coin20 = 0;
    online_pay = 0;
    cancel = 0;

    #20;
    rst = 0;

    // Test Case 1: Product 0 (Price = 20), Pay using 20 coin
    #20;
    select = 2'b00;
    
    #20;
    start = 1;

    #20;
    start = 0;
    
    #10;
    coin20 = 1;
    
    #10;
    coin20 = 0;
    
    #50;

    // Test Case 2: Product 1 (Price = 15), Pay using  10+ 5
    #20;
    select = 2'b01;
    #20;
    start = 1;

    #20;
   start = 0;


    #10;
    coin10 = 1;
    
    #10;
    coin10 = 0;
    
    #10;
    coin5 = 1;
    
    #10;
    coin5 = 0;
      
    #50;

    // Test Case 3: Product 2 (Price = 25), Pay using 20 + 10 (Change = 5)
    #20;
    select = 2'b10;
    
    #20;
    start = 1;

    #20;
    start = 0;

    #10;
    coin20 = 1;
    
    #10;
    coin20 = 0;
    
    #10;
    coin10 = 1;
    
    #10;
    coin10 = 0;
    #60;

    // Test Case 4: Online Payment
    #20;
    select = 2'b11;
    
    #20;
    start = 1;

    #20;
    start = 0;
    
    #20;
    online_pay = 1;
    
    #20;
    online_pay = 0;
    #50;

    // Test Case 5: Cancel Transaction
    #20;
    select = 2'b00;
    
    #20;
    start = 1;

    #20;
    start = 0;
    
    #10;
    coin10 = 1;
    
    #10;
    coin10 = 0;
    
    #20;
    cancel = 1;
    
    #20;
    cancel = 0;
    
    #50;
    
    // Test Case 6: Insufficient Payment (Machine waits for more payment)
    
   #20;
   select = 2'b11;

   #20;
   start = 1;

   #20;
   start = 0;

   #10;
   coin20 = 1;

   #10;
   coin20 = 0;

#50;
    $finish;
end

initial
begin
  $monitor("Time=%0t State=%0d Next=%0d Amount=%0d Price=%0d Change=%0d",
         $time,
         uut.state,
         uut.next_state,
         uut.amount,
         uut.price,
         change);
end

endmodule
