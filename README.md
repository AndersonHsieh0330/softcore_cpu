## Overview
This is a 8 bit "accumulator based" CPU, with a full set of ISA that implements basic arithmetic/logical operations, read and store into memory, and jump/branch instructions.  

## Design Schematic
I drew this picture while I was designing the CPU. A lot of signals are ignored in the diagram but generally the Verilog code implements the IP block structure presented in it.
![schematic diagram](https://github.com/AndersonHsieh0330/softcore_cpu/blob/master/info/schematic_diagram.png)

## Instruction Set Architecture
Check [ISA excel sheet](https://github.com/AndersonHsieh0330/softcore_cpu/blob/master/info/isa.xlsx) for full ISA specification. 

Below is a screenshot of all the instructions for quick access
![instruction_screenshot](https://github.com/AndersonHsieh0330/softcore_cpu/blob/master/info/instructions_screenshot.png)

And there are some assembly code blocks that I wrote to ensure this ISA is capable of implementing most general purpose programs
![example_instruction_block](https://github.com/AndersonHsieh0330/softcore_cpu/blob/master/info/example_instruction_blocks.png?raw=true)

## Types of CPU organization and thoughts behind design choices
Generally there are three types of CPUs
1. Stack based
2. Accumulator based
3. General registers

Most CPUs nowadays uses general registers based organization, but due to the instructions of my design being 8 bits, I'd like to use least number of bits to address the operand register. That way as many bits can be used as opcode as possible to specify the instructions, this also enables me to have enough bits to address all the instructions I want to implement while having extra space for future ISA expansion.

The accumulator based organization uses the accumulator register as an operand to every instruction, which means in each instruction we only need to specify one operand register. For example, in RSIC-V ISA, the "ADD" instruction takes 3 operands registers: "add reg_a, reg_b, reg_c". This assembly instruction adds the values in reg_b and reg_c and store the result in reg_a. In my design with the accumulator based cpu organization, I can simply do "add reg_a" and that implies adding value in reg_a to the accumulator register and store the result in the accumulator register.

## Random Access Memory (RAM)
- Dual port, 256 X 8 bits byte addressible.
- Port 1 used for accessing program memory space, port 2 used for accessing instructions.
- One cycle delay on read and write.
- Verilog arributes(ram_style) are used so specify the inference of synchronous block ram by the Vivado compiler.
- Initialized at FPGA power up using $readmemb on the file named "ram_8_256.data".
- Note that because I want all address to be addressible, while supporting the max integer range of -128 ~ 127, addresses are used directly to access RAM. This is a design choice to cover 256 addresses, and the trade of is that in the future when we might want to incorporate caching, aka reading memory address near the desired memory access, the physical bit cell accessed will be scattered.

## Number formats
all numbers are in 2s complement, which means 8 bit registers can cover -128 ~127

## Optional Extension
1. Incorporate [eeprom_reader_project](https://github.com/AndersonHsieh0330/eeprom_reader) as a IP for reading programs in single EEPROM into RAM.

## Credit and references
I learned a lot from this Udemy course named [Design a CPU by Ross McGowan](https://www.udemy.com/course/design-a-cpu/) and the idea of creating my own cpu started after seeing the 8 bit CPU presented in this course. My design and ISA is VERY different than what was in the course, but it certainly helped me visualized the possible implementation of certain instructions and inspired my design expansions. Props to Ross McGowan and THANK YOU!
