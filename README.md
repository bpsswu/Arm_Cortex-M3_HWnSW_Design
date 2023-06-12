# Arm Cortex-M3 Hardware & Software Design

## Project description
- FPGA-based Arm Cortex-M3 hardware system build and software development
- Creating a Custom IP core and Integrating it into the System
  - Creating an AXI4 IP core in Vivado
  - Creating a Driver code with Xilinx Standalone Library

## Getting Started
### Prerequisite
* Arm Cortex-M3 FPGA DesignStart Xilinx Edition
  
  ⚠️ You need to find the Cortex-M3 DesignStart FPGA Xilinx Edition (AT426) in the Arm Download Hub and download the compressed file.
  It may change over time, but I'll post the link information.
  https://developer.arm.com/downloads/view/AT426
* FPGA Board (Digilent Arty A7-35t)
* Xilinx Vivado & Xilinx SDK (2019.1)
* Arm Keil MDK (5.24a)
* Basic knowledge of Verilog and C language

## Project Flow
![2023-05-27 00 12 29](https://github.com/bpsswu/digital_signature/assets/101001675/46cbe196-194e-488e-bc1a-0640c9f1b7da)

### STEP 1 : IP core design
(Example: 16-bit rsa IP core)
- IP core Hardware Design
  - Verilog HDL & Xilinx Vivado
  - Interface : AXI4 Lite
  - Core : 16-bit level RSA operation
  ![image](https://github.com/bpsswu/Arm_Cortex-M3_HWnSW_Design/assets/101001675/a02afb6c-d732-4114-8a7a-2b4a77e794ae)

### STEP 2 : System Integration
- Block Design in Xilinx Vivado
  - Integrate the designed IP core into the system through the AXI protocol
  ![image](https://github.com/bpsswu/Arm_Cortex-M3_HWnSW_Design/assets/101001675/a5dcad47-14a1-4412-a2ba-7b487aaacfb4)
- Address Map
  - Memory Mapped I/O
  ![image](https://github.com/bpsswu/Arm_Cortex-M3_HWnSW_Design/assets/101001675/5a53df0a-b065-4aa4-a32d-d304c87f1bad)
### STEP 3 : BSP Generation
Xilinx SDK
- Hardware Export
- Launch XSDK
- Generate BSP
### STEP 4 : Create Application SW
Arm Keil MDK
## Directory Structure
