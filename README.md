# Verilog Vending Machine

A Verilog HDL-based vending machine controller designed using a Finite State Machine (FSM).

## Project Overview

This project implements a digital vending machine that accepts ₹5, ₹10, and ₹20 coins. The machine dispenses a product when the accumulated amount reaches ₹20.

The design is written in synthesizable Verilog HDL and verified using a dedicated testbench through simulation in Xilinx Vivado.

## Features

- FSM-based vending machine controller
- Accepts ₹5, ₹10, and ₹20 coins
- Product price: ₹20
- Automatic product dispensing
- Supports multiple coin combinations
- Reset functionality
- Synthesizable RTL design
- Dedicated Verilog testbench
- Vivado simulation and waveform verification

## FSM States

| State | Amount |
|---|---:|
| S0 | ₹0 |
| S5 | ₹5 |
| S10 | ₹10 |
| S15 | ₹15 |
| S20 | ₹20 |

When the accumulated amount reaches ₹20, the machine dispenses the product and returns to the initial state.

## Supported Transactions

| Coins Inserted | Result |
|---|---|
| ₹20 | Product Dispensed |
| ₹10 + ₹10 | Product Dispensed |
| ₹5 + ₹5 + ₹10 | Product Dispensed |
| ₹5 + ₹10 + ₹5 | Product Dispensed |
| ₹5 + ₹5 + ₹5 + ₹5 | Product Dispensed |

## Project Structure

```text
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
```

## Design Methodology

The vending machine is implemented using a Finite State Machine. The FSM keeps track of the amount inserted and changes state according to the incoming coin.

```text
S0  → ₹0
S5  → ₹5
S10 → ₹10
S15 → ₹15
S20 → ₹20
```

When ₹20 is accumulated, the machine generates the `dispense` signal and returns to the initial state.

## Inputs

| Signal | Description |
|---|---|
| `clk` | System clock |
| `reset` | Reset signal |
| `coin_5` | ₹5 coin input |
| `coin_10` | ₹10 coin input |
| `coin_20` | ₹20 coin input |

## Outputs

| Signal | Description |
|---|---|
| `dispense` | Product dispensing signal |
| `change` | Change output |

## Verification

A dedicated Verilog testbench is used to verify the design under multiple transaction scenarios.

The verification includes:

- Direct ₹20 transaction
- Multiple coin combinations
- Product dispensing
- Reset operation
- FSM state transitions
- Simulation waveform analysis

## Tools Used

- Verilog HDL
- Xilinx Vivado
- Vivado Simulator
- Git
- GitHub

## Learning Outcomes

This project demonstrates practical understanding of:

- Finite State Machines
- RTL Design
- Sequential Logic
- Verilog HDL
- Testbench Development
- Functional Verification
- Digital System Design
- FPGA Design Flow

## Future Improvements

- Multiple products
- Different product prices
- Automatic change calculation
- Inventory management
- Seven-segment display interface
- FPGA hardware implementation

## Author

**Aryan MUnjala**

### Project Category

**VLSI | Digital Design | Verilog HDL | FSM**

---

⭐ If you find this project useful, consider giving the repository a star.
