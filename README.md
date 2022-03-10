# MThesisHWisolotion
This repo contains a component calles "protection unit" able to filter AXI transactions using given policy of permitted AXI IDs and address ranges. It is possible to ignore IDs or addresses.

In addition, two other components are contained one manipulate the IDs of AXI transaction, and anotherone to convert AXI-lite to AXI transactions with a given ID. They are used to define ID domains wich policies are based on. 

## Structure
```
├─ip_repo                       # contains actual components
│  ├─AxiIdManipulator_0.1       
│  │  ├─bd                      # scripts to recreate block designes justed for testing
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
5. instanciate the ip in a block design
6. configure the block design using its GUI

---
The thesis itself can be found [here](https://www.overleaf.com/project/612c865f13dfbdab88a60ecf).

