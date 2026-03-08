# APB Protocol Verification using Task-Based Testbench

## Overview

This repository demonstrates the **implementation and verification of the AMBA APB (Advanced Peripheral Bus) protocol** using Verilog HDL.
The project includes an **APB slave memory module** and a **task-based testbench acting as an APB master** to verify read and write transactions.

The simulation was performed using **ModelSim**, and the results confirm correct APB protocol behavior.

---

# AMBA APB Protocol

The **Advanced Peripheral Bus (APB)** is part of the **ARM AMBA bus architecture** and is mainly used for communication with low-bandwidth peripherals such as UART, timers, GPIO, and configuration registers.

APB is designed to be:

* Simple
* Low power
* Easy to implement

---

# APB Signals

| Signal  | Direction | Description                         |
| ------- | --------- | ----------------------------------- |
| PCLK    | Input     | System clock                        |
| PRESETn | Input     | Active-low reset                    |
| PSEL    | Input     | Peripheral select                   |
| PENABLE | Input     | Indicates ACCESS phase              |
| PWRITE  | Input     | Write control (1 = Write, 0 = Read) |
| PADDR   | Input     | Address bus                         |
| PWDATA  | Input     | Write data                          |
| PRDATA  | Output    | Read data                           |
| PREADY  | Output    | Transfer completion signal          |
| PSLVERR | Output    | Error indication                    |

---

# APB Transfer Phases

An APB transfer consists of **two phases**.

## 1. SETUP Phase

* `PSEL = 1`
* `PENABLE = 0`
* Address and control signals become valid.

## 2. ACCESS Phase

* `PSEL = 1`
* `PENABLE = 1`
* Data transfer occurs.

```
Cycle 1 → SETUP
Cycle 2 → ACCESS
```

---

# RTL Design

The APB slave is implemented as a **32-location memory module**.

### Features

* 32 memory locations
* 32-bit data width
* Supports read and write operations
* Finite State Machine implementation

### FSM States

| State  | Description             |
| ------ | ----------------------- |
| IDLE   | Waiting for transaction |
| SETUP  | Address phase           |
| ACCESS | Data transfer phase     |

State transitions follow the **APB protocol timing**.

---

# Task-Based Testbench

The testbench acts as an **APB Master** and verifies the slave module using tasks.

### Testbench Components

* Clock generator
* Reset logic
* Write transaction task
* Read transaction task
* Monitor for observing signals

---

# Tasks Implemented

## Reset Task

Initializes the system and clears signals.

```verilog
task rst;
begin
    psel=0;
    pwdata=0;
    paddr=0;
    penable=0;
    pwrite=0;
    presetn=0;
    @(posedge pclk);
    presetn=1;
end
endtask
```

---

## Write Task

Performs an APB write transaction.

Steps:

1. SETUP phase
2. ACCESS phase
3. Write data into memory

Example transaction:

```
Address = 20
Data    = A5B3C677
```

---

## Read Task

Performs an APB read transaction.

Steps:

1. SETUP phase
2. ACCESS phase
3. Data returned from slave

Example read:

```
Read Address = 20
Expected Data = A5B3C677
```

---

# Verification Process

The verification flow is as follows:

1. Apply system reset
2. Perform write transaction to memory
3. Perform another write to different address
4. Read data from previously written addresses
5. Compare returned data with expected values
6. Display results using `$monitor`

---

# Simulation Results

Simulation output confirms successful transactions.

Example output:

```
psel=1 penable=0 pwrite=1 paddr=20 pwdata=a5b3c677
psel=1 penable=1 pwrite=1 → WRITE COMPLETE

psel=1 penable=0 pwrite=0 paddr=20
psel=1 penable=1 → READ DATA = a5b3c677
```

Memory contents after simulation:

| Address | Data     |
| ------- | -------- |
| 20      | A5B3C677 |
| 10      | FFAABB12 |

---
<img width="1745" height="931" alt="Screenshot 2026-03-08 132908" src="https://github.com/user-attachments/assets/d89bec17-6390-4be2-b7d0-bda232792248" />
<img width="1759" height="911" alt="Screenshot 2026-03-08 132446" src="https://github.com/user-attachments/assets/e427142e-f73d-42bc-933b-c36a5637c002" />



# Tools Used

* Verilog HDL
* ModelSim Simulator

---

# Key Learning Outcomes

* Understanding of **AMBA APB protocol**
* Implementation of **FSM-based APB slave**
* Writing **task-based testbenches**
* Performing **functional verification using simulation**

---



