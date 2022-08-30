# Isolation-Support for Low-Cost SoC-FPGAs
This repo contains a component called _Protection Unit_ able to filter AXI transactions using a configurable policy based on AXI IDs and address ranges.

In addition, a component to manipulate the IDs of AXI transactions, and another one to convert AXI-lite to full AXI transactions with a given ID can be found. They are used to define/overwrite ID domains which policies are based on. 

## Deployment Guide
The project was created in Vivado 2020.2 and should be reopened with it.

1. Clone the repository
2. Load the git submodules (`git submodule update --init`)
3. Add the repository's directory to your IP catalog in Vivado
4. Add these include search paths
   - _<repo_root>_/ProtectionUnit_0.1/lib/common_cells/include
   - _<repo_root>_/ProtectionUnit_0.1/lib/common_cells/
   - _<repo_root>_/ProtectionUnit_0.1/lib/axi/include
   - _<repo_root>_/ProtectionUnit_0.1/lib/axi
   - _<repo_root>_/ProtectionUnit_0.1/hdl
5. Instantiate the component in a block design
6. Configure the component in the block design using its GUI

## Configuration Register Layout
The configuration register contains a control and a status register (not implemented yet) as well as the registers to configure the policy.
Each register is 32-bit wide and can be accessed through a separate AXI-Lite interface.

### Control register
The control register has currently no function implemented. 

Address **0x00**

### Status register
The status register has currently no function implemented. 

Address **0x04**

### Policy Registers
Through policy registers it can be configured which domains may read/write which memory areas.

Within each policy register two bits corresponds to a memory region. 
One bits indicates read permission the other write permission.
If a read or write bit is set the domain of teh policy register has read or write access to the corresponding memory region.

Bits of unused domains and memory regions are always forced 0 by hardware.

Address **0x40 + 0x04 * domain_index** - There is a policy register for each domain

```
                         31                                                            0
                        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
memory region index     | 15| 14| 13| 12| 11| 10| 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
read/write permission   |r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|
                        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```


## Contributing
If you wish to contribute, please contact me at my university email address daniele.passaretti@ovgu.de.

## People
The following people participated:
- [Daniele Passaretti](https://scholar.google.com/citations?user=gZym4L4AAAAJ&hl=de): 
- [Felix Böhm](https://www.xing.com/profile/Felix_Boehm48): Hardware implementation of the lightweight Protection Unit
- [Prof. Dr.-Ing. Thilo Pionteck](https://www.hti.ovgu.de/Lehrstuhl/MitarbeiterInnen/Leiter/Prof_+Dr__Ing_+Thilo+Pionteck-p-36.html): PI


## Acknowledgements
The AXI demutex and error slave, both sub components of the Protection Unit, where taken from the [PULP Platforms AXI implementation](https://github.com/pulp-platform/axi).

## License

This simulator is available to anybody free of charge, under the terms of MIT License:

Copyright (c) 2014-2022 Daniele Passaretti (daniele.passaretti@ovgu.de)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
