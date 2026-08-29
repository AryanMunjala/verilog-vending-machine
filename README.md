# Verilog Vending Machine

A digital vending machine controller designed using **Verilog HDL** and implemented using a **Finite State Machine (FSM)**.

## Project Overview

This project implements a vending machine that accepts ₹5, ₹10, and ₹20 coins. The machine dispenses a product when the accumulated amount reaches the product price of ₹20.

The design is written in synthesizable Verilog HDL and verified using a dedicated testbench through simulation.

## Features

- FSM-based vending machine controller
- Accepts ₹5, ₹10, and ₹20 coins
- Product price: ₹20
- Automatic product dispensing
- Handles different coin combinations
- Reset functionality
- Synthesizable RTL design
- Dedicated Verilog testbench
- Simulation verified using Xilinx Vivado

## FSM States

| State | Amount |
|---|---:|
| S0 | ₹0 |
| S5 | ₹5 |
| S10 | ₹10 |
| S15 | ₹15 |
| S20 | ₹20 |

When the accumulated amount reaches ₹20, the vending machine generates the `dispense` signal and returns to the initial state.

## Supported Transactions

| Coins Inserted | Result |
|---|---|
| ₹20 | Product Dispensed |
| ₹10 + ₹10 | Product Dispensed |
| ₹5 + ₹5 + ₹10 | Product Dispensed |
| ₹5 + ₹10 + ₹5 | Product Dispensed |
| ₹5 + ₹5 + ₹5 + ₹5 | Product Dispensed |

## Project Structure

text
verilog-vending-machine/
│
├── rtl/
│   └── vending_machine.v
│
├── simulation/
│   └── vending_machine_tb.v
│
├── docs/
│   ├── block_diagram.png
│   ├── state_diagram.png
│   └── state_table.png
│
├── screenshots/
│   └── waveform.png
│
├── README.md
└── LICENSE
