# APB Protocol Verification using Task-Based Testbench

## Overview

This project demonstrates the implementation and verification of the **AMBA APB (Advanced Peripheral Bus) protocol** using Verilog.


# AMBA APB Protocol

APB (Advanced Peripheral Bus) is part of the ARM AMBA bus architecture and is used for low-bandwidth peripherals.

## APB Signals

| Signal  | Description         |
| ------- | ------------------- |
| PCLK    | Clock signal        |
| PRESETn | Active low reset    |
| PSEL    | Peripheral select   |
| PENABLE | Enables transfer    |
| PWRITE  | Write control       |
| PADDR   | Address bus         |
| PWDATA  | Write data          |
| PRDATA  | Read data           |
| PREADY  | Transfer completion |
| PSLVERR | Error indication    |

## APB Transfer Phases

### 1. SETUP Phase

* `PSEL = 1`
* `PENABLE = 0`
* Address and control signals are valid.

### 2. ACCESS Phase

* `PSEL = 1`
* `PENABLE = 1`
* Data transfer occurs.

## APB Timing

Cycle 1 → SETUP
Cycle 2 → ACCESS


The design includes:

* APB Slave memory module
* Task-based APB master testbench
* Simulation verification using ModelSim

## Features

* Implementation of APB protocol states
* Task-based verification approach
* Memory read/write transactions
* Simulation output validation


```
# Verification Process

The APB slave design is verified using a task-based testbench.

## Testbench Components

* Clock generator
* Reset logic
* Write transaction task
* Read transaction task
* Monitor for signal observation

## Task-Based Approach

### Reset Task

Initializes the system and clears memory.

### Write Task

Performs APB write transaction:

1. SETUP phase
2. ACCESS phase

### Read Task

Performs APB read transaction and checks returned data.

## Verification Steps

1. Apply reset
2. Write data to memory locations
3. Read data from same locations
4. Compare results with expected values
5. Display results using `$monitor`

## Simulation Result

Successful simulation confirms correct APB read/write behavior.


## APB Transactions Implemented

* Write transaction
* Read transaction
* Memory verification

<img width="1745" height="931" alt="Screenshot 2026-03-08 132908" src="https://github.com/user-attachments/assets/00f7fce3-b2af-435a-bca0-a6c89aa59a82" />
<img width="1759" height="911" alt="Screenshot 2026-03-08 132446" src="https://github.com/user-attachments/assets/031c5e2e-1d41-4946-9402-e715cadec689" />


## Tools Used

* ModelSim
* Verilog HDL

## Author

Your Name
