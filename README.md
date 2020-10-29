# Digital Circuits Final Project: Microwave

2nd year Electronics Engineering at UFSC / EEL5105 - Circuitos e Técnicas Digitais


Microwave simulation on an Altera DE1 FPGA. Components written in VHDL.
- 4 buttons: reset, enter, predef, pause
- 10 switches: binary value input
- 10 LEDs
- 6 seven-segment displays
- 50 MHz clock
- 7 blocks:
  - control: finite-state machine
  - counter: sets clocks, countdown
  - register: store values
  - selector: multiplexer
  - comparator: compare values
  - predefinition: memory that stores predefined heating modes
  - debouncer: button sync tool

Report in Portuguese.
