## Memory
- This softcore cpu has a RAM which is single port, 256 X 8 bits byte addressible. 
- Note that because I want all address to be addressible, while supporting the max integer range of -128 ~ 127, addresses are used directly to access RAM. This is a design choice to cover 256 addresses, and the trade of is that in the future when we might want to incorporate caching, aka reading memory address near the desired memory access, the physical bit cell accessed will be scattered.

## Number formats
- all numbers are in 2s complement, which means 8 bit registers can cover -128 ~127

## Optional Extension
