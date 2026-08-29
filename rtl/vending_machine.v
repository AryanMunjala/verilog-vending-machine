`timescale 1ns/1ps

module vending_machine(
    input        clk,
    input        rst,
    input        start,
    input  [1:0] select,
    input        coin5,
    input        coin10,
    input        coin20,
    input        online_pay,
    input        cancel,
    output reg        dispense,
    output reg        success,
    output reg        failure,
    output reg        refund,
    output reg [5:0]  change
);

reg [3:0] state, next_state;

localparam IDLE          = 4'd0,
           SELECT        = 4'd1,
           PAYMENT       = 4'd2,
           VERIFY        = 4'd3,
           DISPENSE      = 4'd4,
           RETURN_CHANGE = 4'd5,
           REFUND        = 4'd6,
           SUCCESS       = 4'd7,
           FAILURE       = 4'd8;

reg [5:0] price;
reg [5:0] amount;
reg [1:0] product;
always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end
always @(posedge clk or posedge rst)
begin
    if(rst)
        product <= 2'b00;
    else if(state == SELECT)
        product <= select;
end

always @(*)
begin
    case(product)
        2'b00: price = 6'd20;
        2'b01: price = 6'd15;
        2'b10: price = 6'd25;
        2'b11: price = 6'd30;
        default: price = 6'd0;
    endcase
end

always @(posedge clk or posedge rst)
begin
    if (rst)
        amount <= 6'd0;
    else
    begin
        case(state)
            IDLE:
                amount <= 6'd0;

            PAYMENT:
            begin
                if (coin5)
                    amount <= amount + 6'd5;
                else if (coin10)
                    amount <= amount + 6'd10;
                else if (coin20)
                    amount <= amount + 6'd20;
                else if (online_pay)
                    amount <= price;
                else
                    amount <= amount;
            end

            REFUND:
                amount <= 6'd0;

            RETURN_CHANGE:
                 amount <= amount;
        endcase
    end
end

always @(*)
begin
    next_state = state;

    case(state)

        IDLE:
        begin
            if(start)
                next_state = SELECT;
            else
                next_state = IDLE;
        end

        SELECT:
        begin
            if(cancel)
                next_state = REFUND;
            else
                next_state = PAYMENT;
        end

        PAYMENT:
        begin
            if(cancel)
                next_state = REFUND;
            else if(online_pay)
                next_state = VERIFY;
            else if(amount >= price)
                next_state = VERIFY;
            else
                next_state = PAYMENT;
        end

        VERIFY:
        begin
            if(amount >= price)
                next_state = SUCCESS;
            else
                next_state = FAILURE;
        end

        SUCCESS:
            next_state = DISPENSE;

        DISPENSE:
        begin
            if(amount > price)
                next_state = RETURN_CHANGE;
            else
                next_state = IDLE;
        end

        RETURN_CHANGE:
            next_state = IDLE;

        FAILURE:
            next_state = REFUND;

        REFUND:
            next_state = IDLE;

        default:
            next_state = IDLE;

    endcase
end


always @(*)
begin
    dispense = 1'b0;
    success  = 1'b0;
    failure  = 1'b0;
    refund   = 1'b0;
    change   = 6'd0;

    case(state)

        SUCCESS:
            success = 1'b1;

        FAILURE:
            failure = 1'b1;

        DISPENSE:
            dispense = 1'b1;

        RETURN_CHANGE:
        begin
            if (amount > price)
                change = amount - price;
            else
                change = 6'd0;
        end

        REFUND:
        begin
            refund = 1'b1;
            change = amount;
        end

        default:;
        endcase
end

endmodule
