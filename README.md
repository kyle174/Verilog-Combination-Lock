# 4-Bit Combination Lock

## Overview

This project focuses on designing and implementing a 4-bit combination lock, with an emphasis on digital design and logic circuits. The lock operates based on a pre-set 4-bit code (X) and validates user input against this combination to determine access.

## Design and Functionality

### Set Combination

- **Input X:** A 4-bit value set by the user as the lock's combination.
- **Enter Input:** A signal used to confirm the input combination.

### Lock Operation

- **Comparison Logic:** Compares the entered value with the set combination.
- **State Machine:** Manages the lock's states based on the input and comparison results.
- **Output Indicators:** LED indicators show the lock's status (locked/unlocked).

### State Machine Design

- Based on Moore finite state machine principles.
- Manages the operational states of the lock.

### Input Conditioning

- Ensures clean and debounced input signals.
- Utilizes hardware debounced pushbuttons and clock pulses.

## Simulation and Testing

- Conducted separate simulations for each subcircuit and the integrated design.
- Verified functionality using an Altera board.
