# Booth–Baugh-Wooley–Wallace Multiplier

## Overview
This repository implements a **high-speed 8×8 signed binary multiplier** using a hybrid architecture that combines:

- **Radix-8 Booth Encoding**
- **Baugh-Wooley Signed Multiplication Correction**
- **Wallace Tree Reduction**

The goal of this design is to **reduce the number of partial products and improve multiplication speed**, making it suitable for high-performance digital systems such as **DSP units, ALUs, and FPGA/ASIC implementations**.

---

# Architecture

The multiplier consists of three main stages:

## 1. Radix-8 Booth Encoder
The multiplier operand is encoded using **Radix-8 Booth encoding**, which groups **3 bits of the multiplier at a time**.

This technique generates partial products corresponding to:

```
0 × M
±1 × M
±2 × M
±3 × M
±4 × M
```

### Advantages
- Reduces the number of partial products
- Improves multiplier speed
- Efficient signed multiplication

For this **8×8 multiplier**, the encoder generates:

```
Total Partial Products = 30
```

---

## 2. Baugh-Wooley Correction
The **Baugh-Wooley algorithm** is used to correctly handle **two’s complement signed multiplication**.

It works by:
- Transforming negative partial products
- Rearranging sign bits
- Adding correction bits

This allows the multiplier to use **regular reduction structures like Wallace trees** without errors caused by sign bits.

---

## 3. Wallace Tree Reduction
The generated partial products are compressed using a **Wallace Tree structure**.

The Wallace Tree uses:
- **Full Adders**
- **Half Adders**
- **Carry Save Adders**

to reduce multiple rows of partial products into **two final rows**, which are then summed using a ripple carry adder.

### Benefits
- Parallel reduction of partial products
- Reduced propagation delay
- High-speed multiplication

---

# Performance

| Parameter | Value |
|--------|--------|
| Multiplier Size | 8 × 8 |
| Encoding | Radix-8 Booth |
| Sign Handling | Baugh-Wooley |
| Reduction Method | Wallace Tree |
| Partial Products Generated | 30 |
| Average Propagation Delay | ~10 ns |

---

# Simulation

The design was simulated using **Verilog testbench**.

Steps:
1. Compile all modules
2. Run the testbench
3. Verify the output product against expected multiplication results

---

# Results

## Waveform Output

Insert image in GitHub like this:

![Simulation Waveform](results/waveforms/waveform.png)

---

## TCL Console Output

![TCL Console Output](results/tcl_console/console_output.png)

---

# Applications

This multiplier architecture can be used in:

- Digital Signal Processing (DSP)
- Arithmetic Logic Units (ALU)
- Image Processing Hardware
- FPGA Accelerators
- CPU Arithmetic Units

---

# Future Improvements

Possible improvements to this design include:

- Pipelining the Wallace Tree for higher clock frequency
- Extending the design to **16×16 or 32×32 multipliers**
- Using a **Carry Lookahead Adder (CLA)** or **Kogge-Stone Adder** for the final stage
- FPGA resource optimization

---

# Author

**Arju Mukherjee**

B.Tech Electronics / VLSI Enthusiast  
Interested in **Digital Design, Computer Architecture, and High-Performance Hardware Systems**

---

# License

This project is released under the **MIT License**.

Feel free to use, modify, and distribute the design.
