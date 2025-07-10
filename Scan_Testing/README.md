# Scan Testing Project

## Overview
This project implements a **Scan Chain** methodology to test sequential digital circuits efficiently. The design focuses on transforming a basic Circuit Under Test (CUT) into a **Testable-Ready Circuit Under Test (TRCUT)**, utilizing a chain of **Scan D Flip-Flops** to allow for the systematic shifting of test inputs and observation of outputs. 

## Key Components
- **Circuit Under Test (CUT)**: A simple combinational logic circuit created to validate the functionality of the scan chain. 
  - The circuit performs logic operations using XOR gates and produces output based on combinations of input signals.
  
- **Scan D Flip-Flops**: These flip-flops feature an additional serial input to allow shifting in test vectors during scan mode. Each flip-flop holds an intermediate state for further evaluation.
  
- **TRCUT (Testable-Ready Circuit Under Test)**: The CUT is connected to the chain of scan flip-flops, which enables serial loading of test inputs and retrieval of outputs in scan mode.

## Scan Chain Process
1. **Test Vector Input**: Serial input vectors are shifted into the scan flip-flops using the scan chain, which enables comprehensive fault detection by loading various combinations of test inputs.
2. **Circuit Evaluation**: The combinational circuit (CUT) is tested with each vector, and the internal state is evaluated by observing the output at each flip-flop.
3. **Output Observation**: The results are shifted out of the scan flip-flops to be compared with expected values, providing insight into whether the circuit operates correctly.

## Implementation Files
- `scanDFF.vhdl`: Implements the **Scan D Flip-Flop**.
- `Circuit_Under_Test.vhdl`: Implements the combinational logic **Circuit Under Test**.
- `Test_Ready_Circuit_Under_Test.vhdl`: Combines the scan chain with the **CUT** to form the **TRCUT**.
- `scan_testing_testbench.vhdl`: A testbench that loads test vectors into the **TRCUT** and observes the output to check for correctness.

## Simulation Results
The simulation tests various input combinations in scan mode, shifts outputs for comparison, and detects logic errors such as **stuck-at** faults. The timing and correctness of the circuit are verified through detailed waveforms that show the behavior of the circuit under test. The simulation demonstrates the successful application of scan testing.

---
## 👤 Author

> GitHub: [xrddev](https://github.com/xrddev)


## 📝 License

Released under the [MIT License](LICENSE). Originally built as part of a university project.
