# LFSR-MISR Testing Project

## Overview
This project implements a **Built-In Self-Test (BIST)** architecture utilizing **Linear Feedback Shift Registers (LFSRs)** for generating pseudo-random test inputs and **Multiple Input Signature Registers (MISRs)** for output compression. The design is focused on detecting faults in a **Test-Ready Circuit Under Test (TRCUT)** by generating random inputs and comparing the compressed output signature to a known "golden" signature.

The project addresses various fault scenarios, such as **stuck-at-one**, **stuck-at-zero**, and random error injections, with the capability to validate the correct operation of a digital circuit.

---

## VHDL Files and Descriptions

### 1. **LFSR_8_BITS.vhdl**
- Implements an 8-bit **Linear Feedback Shift Register (LFSR)** to generate pseudo-random test vectors. This file creates random binary sequences, ensuring that the maximum length sequence of 8 bits is generated, except for "00000000".
  
- **Key Functionality**: The output is the most significant bit (MSB) of the LFSR sequence, which acts as the serial input for the TRCUT.

---

### 2. **MISR.vhdl**
- Implements a 16-bit **Multiple Input Signature Register (MISR)** to compress the output from the TRCUT into a signature. The signature is then used to detect any discrepancies or faults by comparing it to an expected value.

- **Key Functionality**: The register compresses the output into a signature by feeding the output back into the MISR using XOR gates.

---

### 3. **TRCUT_with_LFSR.vhdl**
- This file integrates the **Test-Ready Circuit Under Test (TRCUT)** with the LFSR. The LFSR provides the test vectors as inputs, and the TRCUT processes them.

- **Key Functionality**: The LFSR-generated random test vectors are applied to the TRCUT, which simulates normal operation. The architecture prevents unnecessary shifting during capture mode by gating the LFSR's clock signal.

---

### 4. **TRCUT_with_LFSR_Testbench.vhdl**
- This file creates a testbench to verify the functionality of the TRCUT combined with the LFSR. The testbench applies 32 random vectors from the LFSR to the TRCUT and captures the output responses.

- **Key Functionality**: The simulation verifies the correct operation by observing the circuit’s response to pseudo-random input vectors.

---

### 5. **Test_Ready_Circuit_Under_Test.vhdl**
- Implements the basic combinational logic of the **Circuit Under Test (CUT)** using XOR gates, designed for testing. It serves as a simple example of a testable circuit.

- **Key Functionality**: The circuit has several input and output signals, and its behavior is modeled using logical operations. This CUT is used in all test scenarios.

---

### 6. **Circuit_Under_Test_noFault.vhdl**
- This is the fault-free version of the CUT. It behaves according to the intended logic without any deliberate errors or injected faults.

- **Key Functionality**: The circuit is used to test if the system behaves correctly in the absence of any faults.

---

### 7. **Circuit_Under_Test_stuckAtOne.vhdl**
- Simulates a **stuck-at-one** fault, where a specific signal in the circuit remains stuck at logic high ('1').

- **Key Functionality**: This architecture is used to test how the TRCUT and MISR behave when a signal is stuck at logic '1'.

---

### 8. **Circuit_Under_Test_stuckAtZero.vhdl**
- Simulates a **stuck-at-zero** fault, where a specific signal in the circuit remains stuck at logic low ('0').

- **Key Functionality**: This architecture tests how the circuit responds when a signal is stuck at logic '0', ensuring that the fault is detectable by the MISR signature.

---

### 9. **TRCUT_with_MISR.vhdl**
- Integrates the TRCUT with both the LFSR and the MISR. This file is used to generate the golden signature by XORing the outputs of the TRCUT and feeding the result into the MISR.

- **Key Functionality**: It provides the final step of generating compressed signatures to check the integrity of the circuit under test.

---

### 10. **TRCUT_WITH_MISR_Testbench_NO_FAULT.vhdl**
- This testbench simulates the system under the assumption that no faults exist in the CUT. The output signature is recorded as the **golden signature**, which is used as a reference for further tests.

- **Key Functionality**: Simulates the correct operation of the entire system, providing a baseline for fault detection.

---

### 11. **TRCUT_WITH_MISR_Testbench_STUCK_AT_ONE.vhdl**
- A testbench for simulating the system with a **stuck-at-one** fault. The testbench records the resulting signature and compares it against the expected signature for fault detection.

---

### 12. **TRCUT_WITH_MISR_Testbench_STUCK_AT_ZERO.vhdl**
- This testbench tests the system with a **stuck-at-zero** fault in the CUT. The output signature is compared to detect the fault.

---

### 13. **TRCUT_WITH_MISR_Testbench_ERROR_INJECTION.vhdl**
- This testbench introduces a single-cycle random error into the system to test the TRCUT's ability to detect and respond to transient faults.

- **Key Functionality**: The testbench dynamically activates an error during one clock cycle, and the MISR captures the resulting incorrect signature.

---

## Testing Process

1. **LFSR Input Generation**:
   - The LFSR generates pseudo-random test vectors that are applied to the TRCUT.
   
2. **MISR Output Compression**:
   - The TRCUT processes the inputs, and the output is compressed into a signature by the MISR.

3. **Fault Simulation**:
   - The system is tested under different fault conditions (stuck-at-one, stuck-at-zero, and error injection) to validate its fault detection capabilities.

## Simulation Results
The project demonstrates the ability to generate a golden signature for a fault-free system and to detect faults when they occur. The compressed signature in the presence of faults differs from the golden signature, thus indicating faults in the circuit.

