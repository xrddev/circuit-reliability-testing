# Circuit Reliability Testing

## Overview

This repository contains three VHDL projects that implement advanced testing methodologies for digital circuits. These projects focus on **Scan Testing**, **LFSR-MISR (Built-In Self-Test)**, and **JTAG Boundary Scan** techniques to detect faults and ensure the reliability of circuits.

## Projects

### 1. **Scan Testing**

This project implements a **Scan Chain** method to test sequential logic circuits, making them testable with minimal external inputs. The design includes the creation of a **Testable-Ready Circuit Under Test (TRCUT)**, where the original circuit is connected to a chain of **Scan D Flip-Flops**. This architecture allows for efficient testing of internal circuit states by shifting test vectors through the flip-flops and observing outputs.

- **Key Components**:
  
  - **Circuit Under Test (CUT)**: A simple combinational logic circuit designed to demonstrate scan testing.
  - **Scan D Flip-Flop**: Modified flip-flops with an additional serial input for scan testing.
  - **TRCUT**: The combinational logic circuit connected with scan flip-flops to form a testable unit.

- **Testing Process**:
  
  - Serial input vectors are shifted into the scan flip-flops while the system is in scan mode.
  - The flip-flops hold the state of the inputs while the combinational circuit is evaluated.
  - The results are captured and shifted out for evaluation.

- **Simulation Results**:
  The simulation includes a detailed testbench that applies various test vectors to the TRCUT, shifts the outputs, and compares them to expected values. Faults such as **stuck-at** errors are detectable through this process.

### 2. **LFSR-MISR Testing (Built-In Self-Test)**

This project introduces **LFSR (Linear Feedback Shift Register)** and **MISR (Multiple Input Signature Register)** components to automate the testing process via pseudo-random inputs and compressed outputs. These elements are part of the **Built-In Self-Test (BIST)** mechanism that can detect faults within the circuit efficiently.

- **LFSR**: 
  
  - Generates pseudo-random test vectors using an 8-bit shift register. The random vectors cover a broad spectrum of input conditions to stress the circuit.

- **MISR**:
  
  - Compresses the circuit's output responses into a signature, which is then compared to a known good signature to detect faults.

- **TRCUT with LFSR and MISR**:
  
  - The original **TRCUT** is connected with the LFSR as the input generator and the MISR as the output compressor.
  - Different fault models are tested, including **stuck-at-one**, **stuck-at-zero**, and error injection models.

- **Simulation Results**:
  
  - The simulation includes testbenches that apply random vectors to the circuit, capture the outputs, and compare the compressed signature to the expected results.
  - The project provides multiple architectures for the Circuit Under Test (CUT) to simulate different fault conditions.

### 3. **JTAG Boundary Scan (IEEE 1149.1)**

This project implements the **JTAG 1149.1** standard, which is widely used for testing and debugging integrated circuits. The JTAG architecture enables testing of internal circuit paths and I/O pins without physical access to the internal nodes of the chip.

- **Key Components**:
  
  - **TAP Controller**: A state machine that controls the test process, shifting data in and out of the scan chain.
  - **Boundary Register Cells (BRCs)**: Cells that capture input and output data for testing.
  - **Instruction Register**: Holds the instruction to be executed (e.g., **BYPASS**, **EXTEST**, **SAMPLE/PRELOAD**).

- **Test Execution**:
  
  - **BYPASS**: Data is passed directly through the boundary scan register without interacting with the circuit.
  - **SAMPLE/PRELOAD**: Captures the input/output states of the circuit for testing while keeping the circuit running.
  - **EXTEST**: Applies external test vectors to the circuit and captures the output.

- **Simulation Results**:
  The project includes testbenches that demonstrate the functionality of the JTAG interface by simulating the execution of the **BYPASS**, **SAMPLE/PRELOAD**, and **EXTEST** instructions. The testbenches verify correct data shifting through the scan chain, proper state transitions in the TAP controller, and expected outputs for given test inputs.

## Getting Started

1. Clone the repository:
   
   ```bash
   git clone https://github.com/xr-dim/Circuit_Reliability_Testing.git
   ```
2. Navigate to the project directory:
   
   ```bash
   cd Circuit_Reliability_Testing/ΧΧΧ
   ```

### Prerequisites

- A VHDL simulator such as **ModelSim**, **Vivado**, or **GHDL**.
- Knowledge of digital testing methodologies such as scan chains, BIST, and JTAG boundary scan techniques.

### Running the Tests

1. Open the project folder for the desired test (Scan Testing, LFSR-MISR, or JTAG).
2. Compile and simulate the provided VHDL code and testbenches.
3. Analyze the simulation outputs to verify fault detection and circuit behavior.

## License

This project is licensed under the MIT License.
# circuit-reliability-testing
# circuit-reliability-testing
