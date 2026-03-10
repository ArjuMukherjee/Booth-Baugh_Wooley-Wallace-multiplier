# High-Performance Hybrid MAC Unit

## Overview
This repository implements a **16-bit Multiply-Accumulate (MAC) Unit** designed for high-speed digital signal processing (DSP). [cite_start]This architecture features a **Hybrid Wallace Tree Accumulator**, which integrates the feedback term directly into the partial product reduction stages[cite: 33]. This design minimizes the critical path delay compared to traditional architectures that use a separate post-multiplication adder.

### Key Features
* [cite_start]**Radix-8 Booth Encoding:** Reduces the number of partial products to only 3 by grouping bits into triplets[cite: 4, 32].
* [cite_start]**Hybrid Wallace Tree:** Merges the 16-bit accumulator feedback directly into the reduction tree[cite: 33].
* [cite_start]**Signed Arithmetic:** Specifically designed for two's complement signed 8-bit inputs[cite: 2, 31].
* [cite_start]**Optimized Critical Path:** Uses parallel reduction via Carry-Save Addition (CSA) before the final summation[cite: 25, 27].

---

# Architecture

The MAC unit operates through three distinct hardware stages:

### 1. Partial Product Generation (Booth Encoder)
[cite_start]The `booth_encoder` module uses **Radix-8 encoding** to generate partial products representing $\{0, \pm 1M, \pm 2M, \pm 3M, \pm 4M\}$[cite: 7, 8, 9, 13].
* [cite_start]**Hard Multiple Handling:** The module pre-calculates $3M$ (`a_x3`) as $2M + 1M$ to ensure high-speed operation[cite: 3].
* [cite_start]**Output:** The encoder generates a 30-bit bus (`PP`) representing 3 encoded partial products for the 8x8 operation[cite: 1, 14].



### 2. Hybrid Wallace Tree Accumulator
The `hybrid_wallace_tree_acc` module is the core innovation of this IP. It takes the 30-bit partial product bus and the 16-bit accumulator feedback (`A`) as inputs[cite: 20].
* [cite_start]**Stage 1 & 2:** Reduces sign-extension bits and high-order bits of the feedback value[cite: 25, 26].
* [cite_start]**Stage 3:** Compresses all remaining bits into a single Sum and Carry vector[cite: 27, 28].
* **Advantage:** Injecting the feedback into the tree eliminates the extra delay of a standalone 16-bit accumulator adder.



### 3. Final Addition & Storage
* [cite_start]**Ripple Carry Adder (RCA):** A 16-bit RCA performs the final vector summation to produce the product-sum[cite: 29, 36].
* [cite_start]**PIPO Register:** A Parallel-In Parallel-Out register stores the result, controlled by a Clock (`clk`), Enable (`E`), and Reset (`rst_n`)[cite: 31, 34].

---

# Module Hierarchy

* [cite_start]`MAC_IP.v`: Top-level wrapper for the MAC system[cite: 31].
* [cite_start]`booth_encoder.v`: Radix-8 encoder and multiplexer logic[cite: 1].
* [cite_start]`hybrid_wallace_tree_acc.v`: The custom reduction tree with integrated feedback[cite: 20].
* [cite_start]`ripple_carry_adder.v`: 16-bit final summation stage[cite: 36].
* [cite_start]`full_adder.v` / `half_adder.v`: Basic arithmetic building blocks[cite: 16, 18].

---

# Performance Specifications

| Parameter | Value |
| :--- | :--- |
| **Multiplier Size** | [cite_start]8 × 8 Signed [cite: 31] |
| **Accumulator Width** | [cite_start]16-bit [cite: 31] |
| **Encoding** | [cite_start]Radix-8 Booth [cite: 4] |
| **Reduction Method** | [cite_start]Hybrid Wallace Tree [cite: 33] |
| **Final Adder** | [cite_start]16-bit Ripple Carry [cite: 36] |

---

# Simulation & Usage

### 1. Setup
Add all `.v` source files to your project in Vivado, ModelSim, or Quartus.

### 2. Operation
1.  [cite_start]Apply a low pulse to `rst_n` to clear the accumulator to 0[cite: 31].
2.  [cite_start]Set the Enable signal `E` to high[cite: 31].
3.  On every rising edge of `clk`, the unit will compute:  
    $OUT = OUT + (A \times B)$

---

# Author
**Arju Mukherjee** B.Tech Electronics / VLSI Enthusiast  
Specializing in Digital Design and Computer Architecture.

# License
This project is released under the **MIT License**.
