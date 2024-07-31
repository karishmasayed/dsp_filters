# FIR Filter RTL Design and Testbench

## FIR Filter Module

The following RTL design describes a 3-tap Finite Impulse Response (FIR) filter. The design uses fixed-point arithmetic with coefficients represented in Q1.15 format. The clock frequency used for the design is 50 kHz, which is suitable for processing audio signals with a maximum frequency of 20 kHz.

### FIR Filter Calculation
The FIR filter output is computed as:
\[ \text{Data\_OUT}[n] = b0 \times \text{Data\_IN}[n] + b1 \times \text{Data\_IN}[n-1] + b2 \times \text{Data\_IN}[n-2] \]

### Coefficients
- \( b0 = 1.0 \) (Q1.15 format: 0x1000)
- \( b1 = 0.5 \) (Q1.15 format: 0x0800)
- \( b2 = 0.25 \) (Q1.15 format: 0x0400)


## Testbench

The testbench verifies the FIR filter design by applying a series of input samples and observing the output. The clock frequency is set to 50 kHz to meet the requirement for audio signal processing.

### Explanation

- The FIR filter module implements the 3-tap FIR filter with given coefficients.
- The testbench provides a clock signal with a frequency of 50 kHz and applies a series of input samples to the FIR filter.
- The output of the FIR filter can be observed to verify the correctness of the filter implementation.
