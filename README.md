# MThesisHWisolotion
This repo contains a component calls "protection unit" able to filter AXI transactions using given policy of permitted AXI IDs and address ranges. It is possible to ignore IDs or addresses.

In addition, two other components are contained one manipulate the IDs of AXI transaction, and another one to convert AXI-lite to AXI transactions with a given ID. They are used to define ID domains which policies are based on. 

## Structure
```
├─ip_repo                       # contains actual components
│  ├─AxiIdManipulator_0.1       
│  │  ├─bd                      # scripts to recreate block designs justed for testing
│  │  ├─drivers                 # Vivado generated     
│  │  ├─example_designs         # Vivado generated
│  │  ├─hdl                     # actual code
│  │  ├─tb                      # test code
│  │  ├─xgui                    # contains GUI for the Vivado block
│  │  └─components.xml          # component meta information 
│  ├─AxiLiteIdManipulator_0.1   
│  │  ├─... # same as AxiIdManipulator_0.1 dir
│  │  .
│  ├─ProtectionUnit_0.1   
│  │  ├─... # same as AxiIdManipulator_0.1 dir
│  │  ├─doc                     # contains additional documentation
│  │  ├─lib                     # submodules containing used libraries
│  │  .
│  └─edit_<dir>.xpr             # respective Vivado project files
├─project                       # exemplary use case Vivado project
├─.gitignore
├─.gitmodules
└─README.md
```
## Deployment Guide
The project was created in Vivado 2020.2 and should be reopened with it.

1. clone the repo
2. load the submodules
3. add the _ip_repo_ directory to your IP catalog
4. add these include search paths
   - _<repo_root>_/ip_repo/ProtectionUnit_0.1/lib/common_cells/include
   - _<repo_root>_/ip_repo/ProtectionUnit_0.1/lib/common_cells/
   - _<repo_root>_/ip_repo/ProtectionUnit_0.1/lib/axi/include
   - _<repo_root>_/ip_repo/ProtectionUnit_0.1/lib/axi
   - _<repo_root>_/ip_repo/ProtectionUnit_0.1/hdl
5. instantiate the ip in a block design
6. configure the block design using its GUI

## Configuration Register Layout
The configuration register contain a control and a status register as well as the register to configure the policy.
Each register is 32-bit wide.
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

Bits of unused domains and memory regions are always force 0 by hardware.

Address **0X40 + 0x04 * domain_index** - There is a policy register for each domain

```
                         31                                                            0
                        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
memory region index     | 15| 14| 13| 12| 11| 10| 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
read/write permission   |r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|r w|
                        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```

---
The thesis itself can be found [here](https://www.overleaf.com/project/612c865f13dfbdab88a60ecf).

