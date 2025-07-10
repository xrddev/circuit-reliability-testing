
# JTAG_1149-1

This repository contains VHDL code and resources for testing the reliability of circuits using the JTAG IEEE 1149.1 standard (Boundary-Scan). The project provides an implementation of core JTAG components in VHDL, enabling systematic testing of integrated circuits (ICs) and their interconnections to detect faults and ensure the reliability of complex digital systems.

## Overview

JTAG IEEE 1149.1 is a widely used standard for boundary-scan testing of circuits, focusing on diagnosing faults such as short circuits and opens. This project implements the core JTAG components in VHDL, allowing for thorough testing of a Circuit Under Test (CUT). The project includes the implementation of the mandatory JTAG instructions (BYPASS, SAMPLE/PRELOAD, EXTEST) and provides testbenches for simulation and verification using Intel Quartus (free version) with ModelSim 13.0sp1.

### Key Components

The key components implemented in this project are:

- **Instruction Register (IR):** A 2-bit register that stores the instructions executed by the JTAG controller, capable of handling mandatory JTAG instructions.
  - File: `IR_REG_JTAG.vhdl`

- **Boundary Register Cell (BRC):** Cells that store data at the boundaries of the IC, allowing testing of connections between different ICs.
  - File: `BR_CELL_JTAG.vhdl`

- **Boundary Register Cells 4 Bits (BRC_4BITS):** A boundary register composed of 4 BRCs, connected appropriately, associated with the inputs of the CUT.
  - File: `BRCell_4bits_JTAG.vhdl`

- **Boundary Register Cells 2 Bits (BRC_2BITS):** A boundary register composed of 2 BRCs, connected appropriately, associated with the outputs of the CUT.
  - File: `BRCell_2bits_JTAG.vhdl`

- **Circuit Under Test (CUT):** The digital circuit module being tested for connectivity issues and defects.
  - File: `Circuit_Under_Test.vhdl`

- **TAP Controller FSM (TAP):** Implements the finite state machine controlling the JTAG Test Access Port, managing transitions between different test states.
  - File: `tap_controler_FSM.vhdl`
  - Note: The `Declare.vhdl` file is necessary as it defines the state type used in the FSM.

- **Bypass Register (BYPASS_REG):** A register that bypasses certain sections of the scan chain, essential for operations that do not require full scan testing.
  - File: `Bypass_REG_JTAG.vhdl`

- **Decoder (DEC):** Responsible for decoding the instructions in the IR and routing them to the appropriate modules.
  - File: `Decoder.vhdl`

- **Top-Level JTAG Module:** Connects all the above components to form the complete JTAG implementation.
  - File: `JTAG_1149.vhdl`

## Features

- **Boundary-Scan Testing:** Implements boundary-scan testing using the components described above to detect common faults like open circuits and shorts.

- **JTAG Instructions:** Supports the mandatory instructions:
  1. **BYPASS:** Allows bypassing of certain parts of the circuit during testing.
  2. **SAMPLE/PRELOAD:** Captures the inputs and outputs of the CUT for testing purposes.
  3. **EXTEST:** External testing of connections between ICs.

- **Testbenches:** Provided to simulate and verify the behavior of JTAG operations in the circuit. Key test sequences include:
  - **BYPASS Instruction Testbench:** Simulates the bypass functionality by routing signals through the bypass register.
  - **SAMPLE/PRELOAD Instruction Testbench:** Tests the ability to sample the state of inputs and outputs of the CUT, storing the values in boundary registers for validation.

## Files

- **VHDL Source Files:**
  - `IR_REG_JTAG.vhdl`
  - `BR_CELL_JTAG.vhdl`
  - `BRCell_4bits_JTAG.vhdl`
  - `BRCell_2bits_JTAG.vhdl`
  - `Circuit_Under_Test.vhdl`
  - `tap_controler_FSM.vhdl`
  - `Bypass_REG_JTAG.vhdl`
  - `Decoder.vhdl`
  - `JTAG_1149.vhdl`
  - `Declare.vhdl` (Defines the state types for the TAP controller FSM)

- **Testbench Files:**
  - `BYPASS_tb.vhdl` (Testbench for BYPASS instruction)
  - `Sample_Preload_tb.vhdl` (Testbench for SAMPLE/PRELOAD instruction)

- **Report:**
  - `JTAG_1149-1.pdf`: Detailed report explaining the implementation and simulation results.

## Simulation and Verification

Simulation and verification of the components are performed using Intel Quartus Prime (free version) with ModelSim 13.0sp1. The provided testbenches can be used to simulate the behavior of the JTAG implementation and verify the correctness of the design.

### How to Run Simulations

1. **Prerequisites:**
   - Intel Quartus II 13.0sp1 (free version) installed on your system.
   - ModelSim for running simulations.

2. **Analyzing Results:**
   - Use the waveform viewer to analyze the signals and verify that the JTAG instructions are executed correctly.
   - Refer to the report `JTAG_1149-1.pdf` for detailed explanations of the expected simulation results.

## Customization

- **Modifying VHDL Code:**
  - You can modify the VHDL files to adapt the components to different testing needs or add new instructions as per the JTAG standard.

- **Creating Custom Testbenches:**
  - You can create your own testbenches to simulate different test scenarios or to test additional functionalities.

## Requirements

- **Intel Quartus II 13.0sp1 (Free Version):** For simulating and verifying the VHDL components.
- **ModelSim :** For running simulations.

## Additional Information

- **Report Details:**
  - The report `JTAG_1149-1.pdf` includes detailed explanations of the implemented components, their interconnections, and simulation results. It also provides insights into how each JTAG instruction is executed within the design.

- **Testbench Explanations:**
  - The testbenches are designed to follow the standard JTAG TAP controller state transitions, ensuring that the instructions are loaded and executed correctly. They simulate the behavior of the TAP controller and demonstrate how the boundary-scan cells capture and shift data.

## License

This project is licensed under the MIT License. Please see the `LICENSE` file for details.
