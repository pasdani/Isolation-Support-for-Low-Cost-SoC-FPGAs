
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/ProtectionUnit_v0_1.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Domains [ipgui::add_page $IPINST -name "Domains"]
  ipgui::add_static_text $IPINST -name "Domain Description" -parent ${Domains} -text {Domains are used to differentiate different masters based on thier AXI ID. 

A membership to a domain is  determined by comparing selected bits of the incoming transactions AXI ID with the Domain Id. The bits are selected according to Domain Mask.

If there is no need to differentiate domain, set Num Domains to 1 and Domain 0 Mask to 0x0000.


}
  ipgui::add_param $IPINST -name "NUM_DOMAINS" -parent ${Domains}
  #Adding Group
  set Domain_0 [ipgui::add_group $IPINST -name "Domain 0" -parent ${Domains} -layout horizontal]
  set DOMAIN_0_ID [ipgui::add_param $IPINST -name "DOMAIN_0_ID" -parent ${Domain_0}]
  set_property tooltip {Domain 0 Id} ${DOMAIN_0_ID}
  set DOMAIN_0_MASK [ipgui::add_param $IPINST -name "DOMAIN_0_MASK" -parent ${Domain_0}]
  set_property tooltip {Domain 0 Mask} ${DOMAIN_0_MASK}

  #Adding Group
  set Domain_1 [ipgui::add_group $IPINST -name "Domain 1" -parent ${Domains} -layout horizontal]
  set DOMAIN_1_ID [ipgui::add_param $IPINST -name "DOMAIN_1_ID" -parent ${Domain_1}]
  set_property tooltip {Domain 1 Id} ${DOMAIN_1_ID}
  set DOMAIN_1_MASK [ipgui::add_param $IPINST -name "DOMAIN_1_MASK" -parent ${Domain_1}]
  set_property tooltip {Domain 1 Mask} ${DOMAIN_1_MASK}

  #Adding Group
  set Domain_2 [ipgui::add_group $IPINST -name "Domain 2" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_2_ID" -parent ${Domain_2}
  set DOMAIN_2_MASK [ipgui::add_param $IPINST -name "DOMAIN_2_MASK" -parent ${Domain_2}]
  set_property tooltip {Domain 2 Mask} ${DOMAIN_2_MASK}

  #Adding Group
  set Domain_3 [ipgui::add_group $IPINST -name "Domain 3" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_3_ID" -parent ${Domain_3}
  set DOMAIN_3_MASK [ipgui::add_param $IPINST -name "DOMAIN_3_MASK" -parent ${Domain_3}]
  set_property tooltip {Domain 3 Mask} ${DOMAIN_3_MASK}

  #Adding Group
  set Domain_4 [ipgui::add_group $IPINST -name "Domain 4" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_4_ID" -parent ${Domain_4}
  set DOMAIN_4_MASK [ipgui::add_param $IPINST -name "DOMAIN_4_MASK" -parent ${Domain_4}]
  set_property tooltip {Domain 4 Mask} ${DOMAIN_4_MASK}

  #Adding Group
  set Domain_5 [ipgui::add_group $IPINST -name "Domain 5" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_5_ID" -parent ${Domain_5}
  set DOMAIN_5_MASK [ipgui::add_param $IPINST -name "DOMAIN_5_MASK" -parent ${Domain_5}]
  set_property tooltip {Domain 5 Mask} ${DOMAIN_5_MASK}

  #Adding Group
  set Domain_6 [ipgui::add_group $IPINST -name "Domain 6" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_6_ID" -parent ${Domain_6}
  set DOMAIN_6_MASK [ipgui::add_param $IPINST -name "DOMAIN_6_MASK" -parent ${Domain_6}]
  set_property tooltip {Domain 6 Mask} ${DOMAIN_6_MASK}

  #Adding Group
  set Domain_7 [ipgui::add_group $IPINST -name "Domain 7" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_7_ID" -parent ${Domain_7}
  set DOMAIN_7_MASK [ipgui::add_param $IPINST -name "DOMAIN_7_MASK" -parent ${Domain_7}]
  set_property tooltip {Domain 7 Mask} ${DOMAIN_7_MASK}

  #Adding Group
  set Domain_8 [ipgui::add_group $IPINST -name "Domain 8" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_8_ID" -parent ${Domain_8}
  set DOMAIN_8_MASK [ipgui::add_param $IPINST -name "DOMAIN_8_MASK" -parent ${Domain_8}]
  set_property tooltip {Domain 8 Mask} ${DOMAIN_8_MASK}

  #Adding Group
  set Domain_9 [ipgui::add_group $IPINST -name "Domain 9" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_9_ID" -parent ${Domain_9}
  set DOMAIN_9_MASK [ipgui::add_param $IPINST -name "DOMAIN_9_MASK" -parent ${Domain_9}]
  set_property tooltip {Domain 9 Mask} ${DOMAIN_9_MASK}

  #Adding Group
  set Domain_10 [ipgui::add_group $IPINST -name "Domain 10" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_10_ID" -parent ${Domain_10}
  set DOMAIN_10_MASK [ipgui::add_param $IPINST -name "DOMAIN_10_MASK" -parent ${Domain_10}]
  set_property tooltip {Domain 10 Mask} ${DOMAIN_10_MASK}

  #Adding Group
  set Domain_11 [ipgui::add_group $IPINST -name "Domain 11" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_11_ID" -parent ${Domain_11}
  set DOMAIN_11_MASK [ipgui::add_param $IPINST -name "DOMAIN_11_MASK" -parent ${Domain_11}]
  set_property tooltip {Domain 11 Mask} ${DOMAIN_11_MASK}

  #Adding Group
  set Domain_12 [ipgui::add_group $IPINST -name "Domain 12" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_12_ID" -parent ${Domain_12}
  set DOMAIN_12_MASK [ipgui::add_param $IPINST -name "DOMAIN_12_MASK" -parent ${Domain_12}]
  set_property tooltip {Domain 12 Mask} ${DOMAIN_12_MASK}

  #Adding Group
  set Domain_13 [ipgui::add_group $IPINST -name "Domain 13" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_13_ID" -parent ${Domain_13}
  set DOMAIN_13_MASK [ipgui::add_param $IPINST -name "DOMAIN_13_MASK" -parent ${Domain_13}]
  set_property tooltip {Domain 13 Mask} ${DOMAIN_13_MASK}

  #Adding Group
  set Domain_14 [ipgui::add_group $IPINST -name "Domain 14" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_14_ID" -parent ${Domain_14}
  set DOMAIN_14_MASK [ipgui::add_param $IPINST -name "DOMAIN_14_MASK" -parent ${Domain_14}]
  set_property tooltip {Domain 14 Mask} ${DOMAIN_14_MASK}

  #Adding Group
  set Domain_15 [ipgui::add_group $IPINST -name "Domain 15" -parent ${Domains} -layout horizontal]
  ipgui::add_param $IPINST -name "DOMAIN_15_ID" -parent ${Domain_15}
  set DOMAIN_15_MASK [ipgui::add_param $IPINST -name "DOMAIN_15_MASK" -parent ${Domain_15}]
  set_property tooltip {Domain 15 Mask} ${DOMAIN_15_MASK}


  #Adding Page
  set Memory_Regions [ipgui::add_page $IPINST -name "Memory Regions"]
  ipgui::add_static_text $IPINST -name "Memory Region Description" -parent ${Memory_Regions} -text {Memory Regions are used to differentiate differnt address spaces. Memory Regions must be aligned but can overlap.

An address region is define by a staring address as well as a position of the least significant bit (LSB). The LSB defines the size of the memory region according to 
size = 2^LSB bytes.

If there is no need to differentiate memory regions set NumMemRegions to 1 and MemRegion 0 Lsb to 32.


}
  ipgui::add_param $IPINST -name "NUM_MEM_REGIONS" -parent ${Memory_Regions}
  #Adding Group
  set Memory_Region_0 [ipgui::add_group $IPINST -name "Memory Region 0" -parent ${Memory_Regions} -layout horizontal]
  set MEM_REGION_0 [ipgui::add_param $IPINST -name "MEM_REGION_0" -parent ${Memory_Region_0}]
  set_property tooltip {Starting address of Memory Region 0. Must align.} ${MEM_REGION_0}
  ipgui::add_param $IPINST -name "MEM_REGION_0_LSB" -parent ${Memory_Region_0}

  #Adding Group
  set Memory_Region_1 [ipgui::add_group $IPINST -name "Memory Region 1" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_1" -parent ${Memory_Region_1}
  ipgui::add_param $IPINST -name "MEM_REGION_1_LSB" -parent ${Memory_Region_1}

  #Adding Group
  set Memory_Region_2 [ipgui::add_group $IPINST -name "Memory Region 2" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_2" -parent ${Memory_Region_2}
  ipgui::add_param $IPINST -name "MEM_REGION_2_LSB" -parent ${Memory_Region_2}

  #Adding Group
  set Memory_Region_3 [ipgui::add_group $IPINST -name "Memory Region 3" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_3" -parent ${Memory_Region_3}
  ipgui::add_param $IPINST -name "MEM_REGION_3_LSB" -parent ${Memory_Region_3}

  #Adding Group
  set Memory_Region_4 [ipgui::add_group $IPINST -name "Memory Region 4" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_4" -parent ${Memory_Region_4}
  ipgui::add_param $IPINST -name "MEM_REGION_4_LSB" -parent ${Memory_Region_4}

  #Adding Group
  set Memory_Region_5 [ipgui::add_group $IPINST -name "Memory Region 5" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_5" -parent ${Memory_Region_5}
  ipgui::add_param $IPINST -name "MEM_REGION_5_LSB" -parent ${Memory_Region_5}

  #Adding Group
  set Memory_Region_6 [ipgui::add_group $IPINST -name "Memory Region 6" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_6" -parent ${Memory_Region_6}
  ipgui::add_param $IPINST -name "MEM_REGION_6_LSB" -parent ${Memory_Region_6}

  #Adding Group
  set Memory_Region_7 [ipgui::add_group $IPINST -name "Memory Region 7" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_7" -parent ${Memory_Region_7}
  ipgui::add_param $IPINST -name "MEM_REGION_7_LSB" -parent ${Memory_Region_7}

  #Adding Group
  set Memory_Region_8 [ipgui::add_group $IPINST -name "Memory Region 8" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_8" -parent ${Memory_Region_8}
  ipgui::add_param $IPINST -name "MEM_REGION_8_LSB" -parent ${Memory_Region_8}

  #Adding Group
  set Memory_Region_9 [ipgui::add_group $IPINST -name "Memory Region 9" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_9" -parent ${Memory_Region_9}
  ipgui::add_param $IPINST -name "MEM_REGION_9_LSB" -parent ${Memory_Region_9}

  #Adding Group
  set Memory_Region_10 [ipgui::add_group $IPINST -name "Memory Region 10" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_10" -parent ${Memory_Region_10}
  ipgui::add_param $IPINST -name "MEM_REGION_10_LSB" -parent ${Memory_Region_10}

  #Adding Group
  set Memory_Region_11 [ipgui::add_group $IPINST -name "Memory Region 11" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_11" -parent ${Memory_Region_11}
  ipgui::add_param $IPINST -name "MEM_REGION_11_LSB" -parent ${Memory_Region_11}

  #Adding Group
  set Memory_Region_12 [ipgui::add_group $IPINST -name "Memory Region 12" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_12" -parent ${Memory_Region_12}
  ipgui::add_param $IPINST -name "MEM_REGION_12_LSB" -parent ${Memory_Region_12}

  #Adding Group
  set Memory_Region_13 [ipgui::add_group $IPINST -name "Memory Region 13" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_13" -parent ${Memory_Region_13}
  ipgui::add_param $IPINST -name "MEM_REGION_13_LSB" -parent ${Memory_Region_13}

  #Adding Group
  set Memory_Region_14 [ipgui::add_group $IPINST -name "Memory Region 14" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_14" -parent ${Memory_Region_14}
  ipgui::add_param $IPINST -name "MEM_REGION_14_LSB" -parent ${Memory_Region_14}

  #Adding Group
  set Memory_Region_15 [ipgui::add_group $IPINST -name "Memory Region 15" -parent ${Memory_Regions} -layout horizontal]
  ipgui::add_param $IPINST -name "MEM_REGION_15" -parent ${Memory_Region_15}
  ipgui::add_param $IPINST -name "MEM_REGION_15_LSB" -parent ${Memory_Region_15}



}

proc update_PARAM_VALUE.DOMAIN_0_ID { PARAM_VALUE.DOMAIN_0_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_0_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_0_ID ${PARAM_VALUE.DOMAIN_0_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_0_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_0_ID
	} else {
		set_property enabled false $DOMAIN_0_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_0_ID { PARAM_VALUE.DOMAIN_0_ID } {
	# Procedure called to validate DOMAIN_0_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_0_MASK { PARAM_VALUE.DOMAIN_0_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_0_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_0_MASK ${PARAM_VALUE.DOMAIN_0_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_0_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_0_MASK
	} else {
		set_property enabled false $DOMAIN_0_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_0_MASK { PARAM_VALUE.DOMAIN_0_MASK } {
	# Procedure called to validate DOMAIN_0_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_10_ID { PARAM_VALUE.DOMAIN_10_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_10_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_10_ID ${PARAM_VALUE.DOMAIN_10_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_10_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_10_ID
	} else {
		set_property enabled false $DOMAIN_10_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_10_ID { PARAM_VALUE.DOMAIN_10_ID } {
	# Procedure called to validate DOMAIN_10_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_10_MASK { PARAM_VALUE.DOMAIN_10_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_10_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_10_MASK ${PARAM_VALUE.DOMAIN_10_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_10_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_10_MASK
	} else {
		set_property enabled false $DOMAIN_10_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_10_MASK { PARAM_VALUE.DOMAIN_10_MASK } {
	# Procedure called to validate DOMAIN_10_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_11_ID { PARAM_VALUE.DOMAIN_11_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_11_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_11_ID ${PARAM_VALUE.DOMAIN_11_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_11_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_11_ID
	} else {
		set_property enabled false $DOMAIN_11_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_11_ID { PARAM_VALUE.DOMAIN_11_ID } {
	# Procedure called to validate DOMAIN_11_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_11_MASK { PARAM_VALUE.DOMAIN_11_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_11_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_11_MASK ${PARAM_VALUE.DOMAIN_11_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_11_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_11_MASK
	} else {
		set_property enabled false $DOMAIN_11_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_11_MASK { PARAM_VALUE.DOMAIN_11_MASK } {
	# Procedure called to validate DOMAIN_11_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_12_ID { PARAM_VALUE.DOMAIN_12_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_12_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_12_ID ${PARAM_VALUE.DOMAIN_12_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_12_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_12_ID
	} else {
		set_property enabled false $DOMAIN_12_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_12_ID { PARAM_VALUE.DOMAIN_12_ID } {
	# Procedure called to validate DOMAIN_12_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_12_MASK { PARAM_VALUE.DOMAIN_12_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_12_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_12_MASK ${PARAM_VALUE.DOMAIN_12_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_12_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_12_MASK
	} else {
		set_property enabled false $DOMAIN_12_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_12_MASK { PARAM_VALUE.DOMAIN_12_MASK } {
	# Procedure called to validate DOMAIN_12_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_13_ID { PARAM_VALUE.DOMAIN_13_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_13_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_13_ID ${PARAM_VALUE.DOMAIN_13_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_13_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_13_ID
	} else {
		set_property enabled false $DOMAIN_13_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_13_ID { PARAM_VALUE.DOMAIN_13_ID } {
	# Procedure called to validate DOMAIN_13_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_13_MASK { PARAM_VALUE.DOMAIN_13_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_13_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_13_MASK ${PARAM_VALUE.DOMAIN_13_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_13_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_13_MASK
	} else {
		set_property enabled false $DOMAIN_13_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_13_MASK { PARAM_VALUE.DOMAIN_13_MASK } {
	# Procedure called to validate DOMAIN_13_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_14_ID { PARAM_VALUE.DOMAIN_14_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_14_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_14_ID ${PARAM_VALUE.DOMAIN_14_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_14_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_14_ID
	} else {
		set_property enabled false $DOMAIN_14_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_14_ID { PARAM_VALUE.DOMAIN_14_ID } {
	# Procedure called to validate DOMAIN_14_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_14_MASK { PARAM_VALUE.DOMAIN_14_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_14_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_14_MASK ${PARAM_VALUE.DOMAIN_14_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_14_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_14_MASK
	} else {
		set_property enabled false $DOMAIN_14_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_14_MASK { PARAM_VALUE.DOMAIN_14_MASK } {
	# Procedure called to validate DOMAIN_14_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_15_ID { PARAM_VALUE.DOMAIN_15_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_15_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_15_ID ${PARAM_VALUE.DOMAIN_15_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_15_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_15_ID
	} else {
		set_property enabled false $DOMAIN_15_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_15_ID { PARAM_VALUE.DOMAIN_15_ID } {
	# Procedure called to validate DOMAIN_15_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_15_MASK { PARAM_VALUE.DOMAIN_15_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_15_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_15_MASK ${PARAM_VALUE.DOMAIN_15_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_15_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_15_MASK
	} else {
		set_property enabled false $DOMAIN_15_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_15_MASK { PARAM_VALUE.DOMAIN_15_MASK } {
	# Procedure called to validate DOMAIN_15_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_1_ID { PARAM_VALUE.DOMAIN_1_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_1_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_1_ID ${PARAM_VALUE.DOMAIN_1_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_1_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_1_ID
	} else {
		set_property enabled false $DOMAIN_1_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_1_ID { PARAM_VALUE.DOMAIN_1_ID } {
	# Procedure called to validate DOMAIN_1_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_1_MASK { PARAM_VALUE.DOMAIN_1_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_1_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_1_MASK ${PARAM_VALUE.DOMAIN_1_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_1_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_1_MASK
	} else {
		set_property enabled false $DOMAIN_1_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_1_MASK { PARAM_VALUE.DOMAIN_1_MASK } {
	# Procedure called to validate DOMAIN_1_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_2_ID { PARAM_VALUE.DOMAIN_2_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_2_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_2_ID ${PARAM_VALUE.DOMAIN_2_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_2_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_2_ID
	} else {
		set_property enabled false $DOMAIN_2_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_2_ID { PARAM_VALUE.DOMAIN_2_ID } {
	# Procedure called to validate DOMAIN_2_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_2_MASK { PARAM_VALUE.DOMAIN_2_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_2_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_2_MASK ${PARAM_VALUE.DOMAIN_2_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_2_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_2_MASK
	} else {
		set_property enabled false $DOMAIN_2_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_2_MASK { PARAM_VALUE.DOMAIN_2_MASK } {
	# Procedure called to validate DOMAIN_2_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_3_ID { PARAM_VALUE.DOMAIN_3_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_3_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_3_ID ${PARAM_VALUE.DOMAIN_3_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_3_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_3_ID
	} else {
		set_property enabled false $DOMAIN_3_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_3_ID { PARAM_VALUE.DOMAIN_3_ID } {
	# Procedure called to validate DOMAIN_3_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_3_MASK { PARAM_VALUE.DOMAIN_3_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_3_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_3_MASK ${PARAM_VALUE.DOMAIN_3_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_3_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_3_MASK
	} else {
		set_property enabled false $DOMAIN_3_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_3_MASK { PARAM_VALUE.DOMAIN_3_MASK } {
	# Procedure called to validate DOMAIN_3_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_4_ID { PARAM_VALUE.DOMAIN_4_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_4_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_4_ID ${PARAM_VALUE.DOMAIN_4_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_4_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_4_ID
	} else {
		set_property enabled false $DOMAIN_4_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_4_ID { PARAM_VALUE.DOMAIN_4_ID } {
	# Procedure called to validate DOMAIN_4_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_4_MASK { PARAM_VALUE.DOMAIN_4_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_4_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_4_MASK ${PARAM_VALUE.DOMAIN_4_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_4_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_4_MASK
	} else {
		set_property enabled false $DOMAIN_4_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_4_MASK { PARAM_VALUE.DOMAIN_4_MASK } {
	# Procedure called to validate DOMAIN_4_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_5_ID { PARAM_VALUE.DOMAIN_5_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_5_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_5_ID ${PARAM_VALUE.DOMAIN_5_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_5_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_5_ID
	} else {
		set_property enabled false $DOMAIN_5_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_5_ID { PARAM_VALUE.DOMAIN_5_ID } {
	# Procedure called to validate DOMAIN_5_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_5_MASK { PARAM_VALUE.DOMAIN_5_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_5_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_5_MASK ${PARAM_VALUE.DOMAIN_5_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_5_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_5_MASK
	} else {
		set_property enabled false $DOMAIN_5_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_5_MASK { PARAM_VALUE.DOMAIN_5_MASK } {
	# Procedure called to validate DOMAIN_5_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_6_ID { PARAM_VALUE.DOMAIN_6_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_6_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_6_ID ${PARAM_VALUE.DOMAIN_6_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_6_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_6_ID
	} else {
		set_property enabled false $DOMAIN_6_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_6_ID { PARAM_VALUE.DOMAIN_6_ID } {
	# Procedure called to validate DOMAIN_6_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_6_MASK { PARAM_VALUE.DOMAIN_6_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_6_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_6_MASK ${PARAM_VALUE.DOMAIN_6_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_6_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_6_MASK
	} else {
		set_property enabled false $DOMAIN_6_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_6_MASK { PARAM_VALUE.DOMAIN_6_MASK } {
	# Procedure called to validate DOMAIN_6_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_7_ID { PARAM_VALUE.DOMAIN_7_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_7_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_7_ID ${PARAM_VALUE.DOMAIN_7_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_7_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_7_ID
	} else {
		set_property enabled false $DOMAIN_7_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_7_ID { PARAM_VALUE.DOMAIN_7_ID } {
	# Procedure called to validate DOMAIN_7_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_7_MASK { PARAM_VALUE.DOMAIN_7_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_7_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_7_MASK ${PARAM_VALUE.DOMAIN_7_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_7_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_7_MASK
	} else {
		set_property enabled false $DOMAIN_7_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_7_MASK { PARAM_VALUE.DOMAIN_7_MASK } {
	# Procedure called to validate DOMAIN_7_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_8_ID { PARAM_VALUE.DOMAIN_8_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_8_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_8_ID ${PARAM_VALUE.DOMAIN_8_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_8_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_8_ID
	} else {
		set_property enabled false $DOMAIN_8_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_8_ID { PARAM_VALUE.DOMAIN_8_ID } {
	# Procedure called to validate DOMAIN_8_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_8_MASK { PARAM_VALUE.DOMAIN_8_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_8_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_8_MASK ${PARAM_VALUE.DOMAIN_8_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_8_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_8_MASK
	} else {
		set_property enabled false $DOMAIN_8_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_8_MASK { PARAM_VALUE.DOMAIN_8_MASK } {
	# Procedure called to validate DOMAIN_8_MASK
	return true
}

proc update_PARAM_VALUE.DOMAIN_9_ID { PARAM_VALUE.DOMAIN_9_ID PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_9_ID when any of the dependent parameters in the arguments change
	
	set DOMAIN_9_ID ${PARAM_VALUE.DOMAIN_9_ID}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_9_ID_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_9_ID
	} else {
		set_property enabled false $DOMAIN_9_ID
	}
}

proc validate_PARAM_VALUE.DOMAIN_9_ID { PARAM_VALUE.DOMAIN_9_ID } {
	# Procedure called to validate DOMAIN_9_ID
	return true
}

proc update_PARAM_VALUE.DOMAIN_9_MASK { PARAM_VALUE.DOMAIN_9_MASK PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update DOMAIN_9_MASK when any of the dependent parameters in the arguments change
	
	set DOMAIN_9_MASK ${PARAM_VALUE.DOMAIN_9_MASK}
	set NUM_DOMAINS ${PARAM_VALUE.NUM_DOMAINS}
	set values(NUM_DOMAINS) [get_property value $NUM_DOMAINS]
	if { [gen_USERPARAMETER_DOMAIN_9_MASK_ENABLEMENT $values(NUM_DOMAINS)] } {
		set_property enabled true $DOMAIN_9_MASK
	} else {
		set_property enabled false $DOMAIN_9_MASK
	}
}

proc validate_PARAM_VALUE.DOMAIN_9_MASK { PARAM_VALUE.DOMAIN_9_MASK } {
	# Procedure called to validate DOMAIN_9_MASK
	return true
}

proc update_PARAM_VALUE.MEM_REGION_0 { PARAM_VALUE.MEM_REGION_0 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_0 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_0 ${PARAM_VALUE.MEM_REGION_0}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_0_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_0
	} else {
		set_property enabled false $MEM_REGION_0
	}
}

proc validate_PARAM_VALUE.MEM_REGION_0 { PARAM_VALUE.MEM_REGION_0 } {
	# Procedure called to validate MEM_REGION_0
	return true
}

proc update_PARAM_VALUE.MEM_REGION_0_LSB { PARAM_VALUE.MEM_REGION_0_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_0_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_0_LSB ${PARAM_VALUE.MEM_REGION_0_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_0_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_0_LSB
	} else {
		set_property enabled false $MEM_REGION_0_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_0_LSB { PARAM_VALUE.MEM_REGION_0_LSB } {
	# Procedure called to validate MEM_REGION_0_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_1 { PARAM_VALUE.MEM_REGION_1 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_1 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_1 ${PARAM_VALUE.MEM_REGION_1}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_1_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_1
	} else {
		set_property enabled false $MEM_REGION_1
	}
}

proc validate_PARAM_VALUE.MEM_REGION_1 { PARAM_VALUE.MEM_REGION_1 } {
	# Procedure called to validate MEM_REGION_1
	return true
}

proc update_PARAM_VALUE.MEM_REGION_10 { PARAM_VALUE.MEM_REGION_10 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_10 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_10 ${PARAM_VALUE.MEM_REGION_10}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_10_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_10
	} else {
		set_property enabled false $MEM_REGION_10
	}
}

proc validate_PARAM_VALUE.MEM_REGION_10 { PARAM_VALUE.MEM_REGION_10 } {
	# Procedure called to validate MEM_REGION_10
	return true
}

proc update_PARAM_VALUE.MEM_REGION_10_LSB { PARAM_VALUE.MEM_REGION_10_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_10_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_10_LSB ${PARAM_VALUE.MEM_REGION_10_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_10_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_10_LSB
	} else {
		set_property enabled false $MEM_REGION_10_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_10_LSB { PARAM_VALUE.MEM_REGION_10_LSB } {
	# Procedure called to validate MEM_REGION_10_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_11 { PARAM_VALUE.MEM_REGION_11 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_11 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_11 ${PARAM_VALUE.MEM_REGION_11}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_11_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_11
	} else {
		set_property enabled false $MEM_REGION_11
	}
}

proc validate_PARAM_VALUE.MEM_REGION_11 { PARAM_VALUE.MEM_REGION_11 } {
	# Procedure called to validate MEM_REGION_11
	return true
}

proc update_PARAM_VALUE.MEM_REGION_11_LSB { PARAM_VALUE.MEM_REGION_11_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_11_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_11_LSB ${PARAM_VALUE.MEM_REGION_11_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_11_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_11_LSB
	} else {
		set_property enabled false $MEM_REGION_11_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_11_LSB { PARAM_VALUE.MEM_REGION_11_LSB } {
	# Procedure called to validate MEM_REGION_11_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_12 { PARAM_VALUE.MEM_REGION_12 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_12 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_12 ${PARAM_VALUE.MEM_REGION_12}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_12_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_12
	} else {
		set_property enabled false $MEM_REGION_12
	}
}

proc validate_PARAM_VALUE.MEM_REGION_12 { PARAM_VALUE.MEM_REGION_12 } {
	# Procedure called to validate MEM_REGION_12
	return true
}

proc update_PARAM_VALUE.MEM_REGION_12_LSB { PARAM_VALUE.MEM_REGION_12_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_12_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_12_LSB ${PARAM_VALUE.MEM_REGION_12_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_12_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_12_LSB
	} else {
		set_property enabled false $MEM_REGION_12_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_12_LSB { PARAM_VALUE.MEM_REGION_12_LSB } {
	# Procedure called to validate MEM_REGION_12_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_13 { PARAM_VALUE.MEM_REGION_13 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_13 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_13 ${PARAM_VALUE.MEM_REGION_13}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_13_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_13
	} else {
		set_property enabled false $MEM_REGION_13
	}
}

proc validate_PARAM_VALUE.MEM_REGION_13 { PARAM_VALUE.MEM_REGION_13 } {
	# Procedure called to validate MEM_REGION_13
	return true
}

proc update_PARAM_VALUE.MEM_REGION_13_LSB { PARAM_VALUE.MEM_REGION_13_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_13_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_13_LSB ${PARAM_VALUE.MEM_REGION_13_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_13_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_13_LSB
	} else {
		set_property enabled false $MEM_REGION_13_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_13_LSB { PARAM_VALUE.MEM_REGION_13_LSB } {
	# Procedure called to validate MEM_REGION_13_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_14 { PARAM_VALUE.MEM_REGION_14 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_14 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_14 ${PARAM_VALUE.MEM_REGION_14}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_14_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_14
	} else {
		set_property enabled false $MEM_REGION_14
	}
}

proc validate_PARAM_VALUE.MEM_REGION_14 { PARAM_VALUE.MEM_REGION_14 } {
	# Procedure called to validate MEM_REGION_14
	return true
}

proc update_PARAM_VALUE.MEM_REGION_14_LSB { PARAM_VALUE.MEM_REGION_14_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_14_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_14_LSB ${PARAM_VALUE.MEM_REGION_14_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_14_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_14_LSB
	} else {
		set_property enabled false $MEM_REGION_14_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_14_LSB { PARAM_VALUE.MEM_REGION_14_LSB } {
	# Procedure called to validate MEM_REGION_14_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_15 { PARAM_VALUE.MEM_REGION_15 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_15 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_15 ${PARAM_VALUE.MEM_REGION_15}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_15_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_15
	} else {
		set_property enabled false $MEM_REGION_15
	}
}

proc validate_PARAM_VALUE.MEM_REGION_15 { PARAM_VALUE.MEM_REGION_15 } {
	# Procedure called to validate MEM_REGION_15
	return true
}

proc update_PARAM_VALUE.MEM_REGION_15_LSB { PARAM_VALUE.MEM_REGION_15_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_15_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_15_LSB ${PARAM_VALUE.MEM_REGION_15_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_15_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_15_LSB
	} else {
		set_property enabled false $MEM_REGION_15_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_15_LSB { PARAM_VALUE.MEM_REGION_15_LSB } {
	# Procedure called to validate MEM_REGION_15_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_1_LSB { PARAM_VALUE.MEM_REGION_1_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_1_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_1_LSB ${PARAM_VALUE.MEM_REGION_1_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_1_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_1_LSB
	} else {
		set_property enabled false $MEM_REGION_1_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_1_LSB { PARAM_VALUE.MEM_REGION_1_LSB } {
	# Procedure called to validate MEM_REGION_1_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_2 { PARAM_VALUE.MEM_REGION_2 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_2 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_2 ${PARAM_VALUE.MEM_REGION_2}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_2_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_2
	} else {
		set_property enabled false $MEM_REGION_2
	}
}

proc validate_PARAM_VALUE.MEM_REGION_2 { PARAM_VALUE.MEM_REGION_2 } {
	# Procedure called to validate MEM_REGION_2
	return true
}

proc update_PARAM_VALUE.MEM_REGION_2_LSB { PARAM_VALUE.MEM_REGION_2_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_2_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_2_LSB ${PARAM_VALUE.MEM_REGION_2_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_2_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_2_LSB
	} else {
		set_property enabled false $MEM_REGION_2_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_2_LSB { PARAM_VALUE.MEM_REGION_2_LSB } {
	# Procedure called to validate MEM_REGION_2_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_3 { PARAM_VALUE.MEM_REGION_3 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_3 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_3 ${PARAM_VALUE.MEM_REGION_3}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_3_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_3
	} else {
		set_property enabled false $MEM_REGION_3
	}
}

proc validate_PARAM_VALUE.MEM_REGION_3 { PARAM_VALUE.MEM_REGION_3 } {
	# Procedure called to validate MEM_REGION_3
	return true
}

proc update_PARAM_VALUE.MEM_REGION_3_LSB { PARAM_VALUE.MEM_REGION_3_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_3_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_3_LSB ${PARAM_VALUE.MEM_REGION_3_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_3_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_3_LSB
	} else {
		set_property enabled false $MEM_REGION_3_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_3_LSB { PARAM_VALUE.MEM_REGION_3_LSB } {
	# Procedure called to validate MEM_REGION_3_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_4 { PARAM_VALUE.MEM_REGION_4 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_4 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_4 ${PARAM_VALUE.MEM_REGION_4}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_4_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_4
	} else {
		set_property enabled false $MEM_REGION_4
	}
}

proc validate_PARAM_VALUE.MEM_REGION_4 { PARAM_VALUE.MEM_REGION_4 } {
	# Procedure called to validate MEM_REGION_4
	return true
}

proc update_PARAM_VALUE.MEM_REGION_4_LSB { PARAM_VALUE.MEM_REGION_4_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_4_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_4_LSB ${PARAM_VALUE.MEM_REGION_4_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_4_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_4_LSB
	} else {
		set_property enabled false $MEM_REGION_4_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_4_LSB { PARAM_VALUE.MEM_REGION_4_LSB } {
	# Procedure called to validate MEM_REGION_4_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_5 { PARAM_VALUE.MEM_REGION_5 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_5 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_5 ${PARAM_VALUE.MEM_REGION_5}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_5_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_5
	} else {
		set_property enabled false $MEM_REGION_5
	}
}

proc validate_PARAM_VALUE.MEM_REGION_5 { PARAM_VALUE.MEM_REGION_5 } {
	# Procedure called to validate MEM_REGION_5
	return true
}

proc update_PARAM_VALUE.MEM_REGION_5_LSB { PARAM_VALUE.MEM_REGION_5_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_5_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_5_LSB ${PARAM_VALUE.MEM_REGION_5_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_5_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_5_LSB
	} else {
		set_property enabled false $MEM_REGION_5_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_5_LSB { PARAM_VALUE.MEM_REGION_5_LSB } {
	# Procedure called to validate MEM_REGION_5_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_6 { PARAM_VALUE.MEM_REGION_6 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_6 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_6 ${PARAM_VALUE.MEM_REGION_6}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_6_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_6
	} else {
		set_property enabled false $MEM_REGION_6
	}
}

proc validate_PARAM_VALUE.MEM_REGION_6 { PARAM_VALUE.MEM_REGION_6 } {
	# Procedure called to validate MEM_REGION_6
	return true
}

proc update_PARAM_VALUE.MEM_REGION_6_LSB { PARAM_VALUE.MEM_REGION_6_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_6_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_6_LSB ${PARAM_VALUE.MEM_REGION_6_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_6_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_6_LSB
	} else {
		set_property enabled false $MEM_REGION_6_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_6_LSB { PARAM_VALUE.MEM_REGION_6_LSB } {
	# Procedure called to validate MEM_REGION_6_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_7 { PARAM_VALUE.MEM_REGION_7 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_7 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_7 ${PARAM_VALUE.MEM_REGION_7}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_7_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_7
	} else {
		set_property enabled false $MEM_REGION_7
	}
}

proc validate_PARAM_VALUE.MEM_REGION_7 { PARAM_VALUE.MEM_REGION_7 } {
	# Procedure called to validate MEM_REGION_7
	return true
}

proc update_PARAM_VALUE.MEM_REGION_7_LSB { PARAM_VALUE.MEM_REGION_7_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_7_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_7_LSB ${PARAM_VALUE.MEM_REGION_7_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_7_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_7_LSB
	} else {
		set_property enabled false $MEM_REGION_7_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_7_LSB { PARAM_VALUE.MEM_REGION_7_LSB } {
	# Procedure called to validate MEM_REGION_7_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_8 { PARAM_VALUE.MEM_REGION_8 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_8 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_8 ${PARAM_VALUE.MEM_REGION_8}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_8_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_8
	} else {
		set_property enabled false $MEM_REGION_8
	}
}

proc validate_PARAM_VALUE.MEM_REGION_8 { PARAM_VALUE.MEM_REGION_8 } {
	# Procedure called to validate MEM_REGION_8
	return true
}

proc update_PARAM_VALUE.MEM_REGION_8_LSB { PARAM_VALUE.MEM_REGION_8_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_8_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_8_LSB ${PARAM_VALUE.MEM_REGION_8_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_8_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_8_LSB
	} else {
		set_property enabled false $MEM_REGION_8_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_8_LSB { PARAM_VALUE.MEM_REGION_8_LSB } {
	# Procedure called to validate MEM_REGION_8_LSB
	return true
}

proc update_PARAM_VALUE.MEM_REGION_9 { PARAM_VALUE.MEM_REGION_9 PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_9 when any of the dependent parameters in the arguments change
	
	set MEM_REGION_9 ${PARAM_VALUE.MEM_REGION_9}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_9_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_9
	} else {
		set_property enabled false $MEM_REGION_9
	}
}

proc validate_PARAM_VALUE.MEM_REGION_9 { PARAM_VALUE.MEM_REGION_9 } {
	# Procedure called to validate MEM_REGION_9
	return true
}

proc update_PARAM_VALUE.MEM_REGION_9_LSB { PARAM_VALUE.MEM_REGION_9_LSB PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update MEM_REGION_9_LSB when any of the dependent parameters in the arguments change
	
	set MEM_REGION_9_LSB ${PARAM_VALUE.MEM_REGION_9_LSB}
	set NUM_MEM_REGIONS ${PARAM_VALUE.NUM_MEM_REGIONS}
	set values(NUM_MEM_REGIONS) [get_property value $NUM_MEM_REGIONS]
	if { [gen_USERPARAMETER_MEM_REGION_9_LSB_ENABLEMENT $values(NUM_MEM_REGIONS)] } {
		set_property enabled true $MEM_REGION_9_LSB
	} else {
		set_property enabled false $MEM_REGION_9_LSB
	}
}

proc validate_PARAM_VALUE.MEM_REGION_9_LSB { PARAM_VALUE.MEM_REGION_9_LSB } {
	# Procedure called to validate MEM_REGION_9_LSB
	return true
}

proc update_PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH { PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH } {
	# Procedure called to update AXI_CONFIG_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH { PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH } {
	# Procedure called to validate AXI_CONFIG_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_CONFIG_DATA_WIDTH { PARAM_VALUE.AXI_CONFIG_DATA_WIDTH } {
	# Procedure called to update AXI_CONFIG_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_CONFIG_DATA_WIDTH { PARAM_VALUE.AXI_CONFIG_DATA_WIDTH } {
	# Procedure called to validate AXI_CONFIG_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_ADDR_WIDTH { PARAM_VALUE.AXI_PT_ADDR_WIDTH } {
	# Procedure called to update AXI_PT_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_ADDR_WIDTH { PARAM_VALUE.AXI_PT_ADDR_WIDTH } {
	# Procedure called to validate AXI_PT_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_ARUSER_WIDTH { PARAM_VALUE.AXI_PT_ARUSER_WIDTH } {
	# Procedure called to update AXI_PT_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_ARUSER_WIDTH { PARAM_VALUE.AXI_PT_ARUSER_WIDTH } {
	# Procedure called to validate AXI_PT_ARUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_AWUSER_WIDTH { PARAM_VALUE.AXI_PT_AWUSER_WIDTH } {
	# Procedure called to update AXI_PT_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_AWUSER_WIDTH { PARAM_VALUE.AXI_PT_AWUSER_WIDTH } {
	# Procedure called to validate AXI_PT_AWUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_BURST_LEN { PARAM_VALUE.AXI_PT_BURST_LEN } {
	# Procedure called to update AXI_PT_BURST_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_BURST_LEN { PARAM_VALUE.AXI_PT_BURST_LEN } {
	# Procedure called to validate AXI_PT_BURST_LEN
	return true
}

proc update_PARAM_VALUE.AXI_PT_BUSER_WIDTH { PARAM_VALUE.AXI_PT_BUSER_WIDTH } {
	# Procedure called to update AXI_PT_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_BUSER_WIDTH { PARAM_VALUE.AXI_PT_BUSER_WIDTH } {
	# Procedure called to validate AXI_PT_BUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_DATA_WIDTH { PARAM_VALUE.AXI_PT_DATA_WIDTH } {
	# Procedure called to update AXI_PT_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_DATA_WIDTH { PARAM_VALUE.AXI_PT_DATA_WIDTH } {
	# Procedure called to validate AXI_PT_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_ID_WIDTH { PARAM_VALUE.AXI_PT_ID_WIDTH } {
	# Procedure called to update AXI_PT_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_ID_WIDTH { PARAM_VALUE.AXI_PT_ID_WIDTH } {
	# Procedure called to validate AXI_PT_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_RUSER_WIDTH { PARAM_VALUE.AXI_PT_RUSER_WIDTH } {
	# Procedure called to update AXI_PT_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_RUSER_WIDTH { PARAM_VALUE.AXI_PT_RUSER_WIDTH } {
	# Procedure called to validate AXI_PT_RUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR { PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR } {
	# Procedure called to update AXI_PT_TARGET_SLAVE_BASE_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR { PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR } {
	# Procedure called to validate AXI_PT_TARGET_SLAVE_BASE_ADDR
	return true
}

proc update_PARAM_VALUE.AXI_PT_WUSER_WIDTH { PARAM_VALUE.AXI_PT_WUSER_WIDTH } {
	# Procedure called to update AXI_PT_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_PT_WUSER_WIDTH { PARAM_VALUE.AXI_PT_WUSER_WIDTH } {
	# Procedure called to validate AXI_PT_WUSER_WIDTH
	return true
}

proc update_PARAM_VALUE.NUM_DOMAINS { PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to update NUM_DOMAINS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_DOMAINS { PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to validate NUM_DOMAINS
	return true
}

proc update_PARAM_VALUE.NUM_MEM_REGIONS { PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to update NUM_MEM_REGIONS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_MEM_REGIONS { PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to validate NUM_MEM_REGIONS
	return true
}

proc update_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to update C_S_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to validate C_S_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to update C_S_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to validate C_S_AXI_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_CONFIG_BASEADDR { PARAM_VALUE.C_S_AXI_CONFIG_BASEADDR } {
	# Procedure called to update C_S_AXI_CONFIG_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_CONFIG_BASEADDR { PARAM_VALUE.C_S_AXI_CONFIG_BASEADDR } {
	# Procedure called to validate C_S_AXI_CONFIG_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_CONFIG_HIGHADDR { PARAM_VALUE.C_S_AXI_CONFIG_HIGHADDR } {
	# Procedure called to update C_S_AXI_CONFIG_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_CONFIG_HIGHADDR { PARAM_VALUE.C_S_AXI_CONFIG_HIGHADDR } {
	# Procedure called to validate C_S_AXI_CONFIG_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.NUM_MEM_REGIONS { MODELPARAM_VALUE.NUM_MEM_REGIONS PARAM_VALUE.NUM_MEM_REGIONS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_MEM_REGIONS}] ${MODELPARAM_VALUE.NUM_MEM_REGIONS}
}

proc update_MODELPARAM_VALUE.NUM_DOMAINS { MODELPARAM_VALUE.NUM_DOMAINS PARAM_VALUE.NUM_DOMAINS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_DOMAINS}] ${MODELPARAM_VALUE.NUM_DOMAINS}
}

proc update_MODELPARAM_VALUE.AXI_CONFIG_DATA_WIDTH { MODELPARAM_VALUE.AXI_CONFIG_DATA_WIDTH PARAM_VALUE.AXI_CONFIG_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_CONFIG_DATA_WIDTH}] ${MODELPARAM_VALUE.AXI_CONFIG_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_CONFIG_ADDR_WIDTH { MODELPARAM_VALUE.AXI_CONFIG_ADDR_WIDTH PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_CONFIG_ADDR_WIDTH}] ${MODELPARAM_VALUE.AXI_CONFIG_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR { MODELPARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR}] ${MODELPARAM_VALUE.AXI_PT_TARGET_SLAVE_BASE_ADDR}
}

proc update_MODELPARAM_VALUE.AXI_PT_BURST_LEN { MODELPARAM_VALUE.AXI_PT_BURST_LEN PARAM_VALUE.AXI_PT_BURST_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_BURST_LEN}] ${MODELPARAM_VALUE.AXI_PT_BURST_LEN}
}

proc update_MODELPARAM_VALUE.AXI_PT_ID_WIDTH { MODELPARAM_VALUE.AXI_PT_ID_WIDTH PARAM_VALUE.AXI_PT_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_ID_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_DATA_WIDTH { MODELPARAM_VALUE.AXI_PT_DATA_WIDTH PARAM_VALUE.AXI_PT_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_DATA_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_ADDR_WIDTH { MODELPARAM_VALUE.AXI_PT_ADDR_WIDTH PARAM_VALUE.AXI_PT_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_ADDR_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_AWUSER_WIDTH { MODELPARAM_VALUE.AXI_PT_AWUSER_WIDTH PARAM_VALUE.AXI_PT_AWUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_AWUSER_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_ARUSER_WIDTH { MODELPARAM_VALUE.AXI_PT_ARUSER_WIDTH PARAM_VALUE.AXI_PT_ARUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_ARUSER_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_WUSER_WIDTH { MODELPARAM_VALUE.AXI_PT_WUSER_WIDTH PARAM_VALUE.AXI_PT_WUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_WUSER_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_RUSER_WIDTH { MODELPARAM_VALUE.AXI_PT_RUSER_WIDTH PARAM_VALUE.AXI_PT_RUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_RUSER_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_PT_BUSER_WIDTH { MODELPARAM_VALUE.AXI_PT_BUSER_WIDTH PARAM_VALUE.AXI_PT_BUSER_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_PT_BUSER_WIDTH}] ${MODELPARAM_VALUE.AXI_PT_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.MEM_REGION_0 { MODELPARAM_VALUE.MEM_REGION_0 PARAM_VALUE.MEM_REGION_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_0}] ${MODELPARAM_VALUE.MEM_REGION_0}
}

proc update_MODELPARAM_VALUE.MEM_REGION_1 { MODELPARAM_VALUE.MEM_REGION_1 PARAM_VALUE.MEM_REGION_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_1}] ${MODELPARAM_VALUE.MEM_REGION_1}
}

proc update_MODELPARAM_VALUE.MEM_REGION_2 { MODELPARAM_VALUE.MEM_REGION_2 PARAM_VALUE.MEM_REGION_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_2}] ${MODELPARAM_VALUE.MEM_REGION_2}
}

proc update_MODELPARAM_VALUE.MEM_REGION_3 { MODELPARAM_VALUE.MEM_REGION_3 PARAM_VALUE.MEM_REGION_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_3}] ${MODELPARAM_VALUE.MEM_REGION_3}
}

proc update_MODELPARAM_VALUE.MEM_REGION_4 { MODELPARAM_VALUE.MEM_REGION_4 PARAM_VALUE.MEM_REGION_4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_4}] ${MODELPARAM_VALUE.MEM_REGION_4}
}

proc update_MODELPARAM_VALUE.MEM_REGION_5 { MODELPARAM_VALUE.MEM_REGION_5 PARAM_VALUE.MEM_REGION_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_5}] ${MODELPARAM_VALUE.MEM_REGION_5}
}

proc update_MODELPARAM_VALUE.MEM_REGION_6 { MODELPARAM_VALUE.MEM_REGION_6 PARAM_VALUE.MEM_REGION_6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_6}] ${MODELPARAM_VALUE.MEM_REGION_6}
}

proc update_MODELPARAM_VALUE.MEM_REGION_7 { MODELPARAM_VALUE.MEM_REGION_7 PARAM_VALUE.MEM_REGION_7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_7}] ${MODELPARAM_VALUE.MEM_REGION_7}
}

proc update_MODELPARAM_VALUE.MEM_REGION_8 { MODELPARAM_VALUE.MEM_REGION_8 PARAM_VALUE.MEM_REGION_8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_8}] ${MODELPARAM_VALUE.MEM_REGION_8}
}

proc update_MODELPARAM_VALUE.MEM_REGION_9 { MODELPARAM_VALUE.MEM_REGION_9 PARAM_VALUE.MEM_REGION_9 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_9}] ${MODELPARAM_VALUE.MEM_REGION_9}
}

proc update_MODELPARAM_VALUE.MEM_REGION_10 { MODELPARAM_VALUE.MEM_REGION_10 PARAM_VALUE.MEM_REGION_10 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_10}] ${MODELPARAM_VALUE.MEM_REGION_10}
}

proc update_MODELPARAM_VALUE.MEM_REGION_11 { MODELPARAM_VALUE.MEM_REGION_11 PARAM_VALUE.MEM_REGION_11 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_11}] ${MODELPARAM_VALUE.MEM_REGION_11}
}

proc update_MODELPARAM_VALUE.MEM_REGION_12 { MODELPARAM_VALUE.MEM_REGION_12 PARAM_VALUE.MEM_REGION_12 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_12}] ${MODELPARAM_VALUE.MEM_REGION_12}
}

proc update_MODELPARAM_VALUE.MEM_REGION_13 { MODELPARAM_VALUE.MEM_REGION_13 PARAM_VALUE.MEM_REGION_13 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_13}] ${MODELPARAM_VALUE.MEM_REGION_13}
}

proc update_MODELPARAM_VALUE.MEM_REGION_14 { MODELPARAM_VALUE.MEM_REGION_14 PARAM_VALUE.MEM_REGION_14 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_14}] ${MODELPARAM_VALUE.MEM_REGION_14}
}

proc update_MODELPARAM_VALUE.MEM_REGION_15 { MODELPARAM_VALUE.MEM_REGION_15 PARAM_VALUE.MEM_REGION_15 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_15}] ${MODELPARAM_VALUE.MEM_REGION_15}
}

proc update_MODELPARAM_VALUE.MEM_REGION_0_LSB { MODELPARAM_VALUE.MEM_REGION_0_LSB PARAM_VALUE.MEM_REGION_0_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_0_LSB}] ${MODELPARAM_VALUE.MEM_REGION_0_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_1_LSB { MODELPARAM_VALUE.MEM_REGION_1_LSB PARAM_VALUE.MEM_REGION_1_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_1_LSB}] ${MODELPARAM_VALUE.MEM_REGION_1_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_2_LSB { MODELPARAM_VALUE.MEM_REGION_2_LSB PARAM_VALUE.MEM_REGION_2_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_2_LSB}] ${MODELPARAM_VALUE.MEM_REGION_2_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_3_LSB { MODELPARAM_VALUE.MEM_REGION_3_LSB PARAM_VALUE.MEM_REGION_3_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_3_LSB}] ${MODELPARAM_VALUE.MEM_REGION_3_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_4_LSB { MODELPARAM_VALUE.MEM_REGION_4_LSB PARAM_VALUE.MEM_REGION_4_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_4_LSB}] ${MODELPARAM_VALUE.MEM_REGION_4_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_5_LSB { MODELPARAM_VALUE.MEM_REGION_5_LSB PARAM_VALUE.MEM_REGION_5_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_5_LSB}] ${MODELPARAM_VALUE.MEM_REGION_5_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_6_LSB { MODELPARAM_VALUE.MEM_REGION_6_LSB PARAM_VALUE.MEM_REGION_6_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_6_LSB}] ${MODELPARAM_VALUE.MEM_REGION_6_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_7_LSB { MODELPARAM_VALUE.MEM_REGION_7_LSB PARAM_VALUE.MEM_REGION_7_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_7_LSB}] ${MODELPARAM_VALUE.MEM_REGION_7_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_8_LSB { MODELPARAM_VALUE.MEM_REGION_8_LSB PARAM_VALUE.MEM_REGION_8_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_8_LSB}] ${MODELPARAM_VALUE.MEM_REGION_8_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_9_LSB { MODELPARAM_VALUE.MEM_REGION_9_LSB PARAM_VALUE.MEM_REGION_9_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_9_LSB}] ${MODELPARAM_VALUE.MEM_REGION_9_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_10_LSB { MODELPARAM_VALUE.MEM_REGION_10_LSB PARAM_VALUE.MEM_REGION_10_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_10_LSB}] ${MODELPARAM_VALUE.MEM_REGION_10_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_11_LSB { MODELPARAM_VALUE.MEM_REGION_11_LSB PARAM_VALUE.MEM_REGION_11_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_11_LSB}] ${MODELPARAM_VALUE.MEM_REGION_11_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_12_LSB { MODELPARAM_VALUE.MEM_REGION_12_LSB PARAM_VALUE.MEM_REGION_12_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_12_LSB}] ${MODELPARAM_VALUE.MEM_REGION_12_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_13_LSB { MODELPARAM_VALUE.MEM_REGION_13_LSB PARAM_VALUE.MEM_REGION_13_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_13_LSB}] ${MODELPARAM_VALUE.MEM_REGION_13_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_14_LSB { MODELPARAM_VALUE.MEM_REGION_14_LSB PARAM_VALUE.MEM_REGION_14_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_14_LSB}] ${MODELPARAM_VALUE.MEM_REGION_14_LSB}
}

proc update_MODELPARAM_VALUE.MEM_REGION_15_LSB { MODELPARAM_VALUE.MEM_REGION_15_LSB PARAM_VALUE.MEM_REGION_15_LSB } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_REGION_15_LSB}] ${MODELPARAM_VALUE.MEM_REGION_15_LSB}
}

proc update_MODELPARAM_VALUE.DOMAIN_0_ID { MODELPARAM_VALUE.DOMAIN_0_ID PARAM_VALUE.DOMAIN_0_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_0_ID}] ${MODELPARAM_VALUE.DOMAIN_0_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_1_ID { MODELPARAM_VALUE.DOMAIN_1_ID PARAM_VALUE.DOMAIN_1_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_1_ID}] ${MODELPARAM_VALUE.DOMAIN_1_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_2_ID { MODELPARAM_VALUE.DOMAIN_2_ID PARAM_VALUE.DOMAIN_2_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_2_ID}] ${MODELPARAM_VALUE.DOMAIN_2_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_3_ID { MODELPARAM_VALUE.DOMAIN_3_ID PARAM_VALUE.DOMAIN_3_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_3_ID}] ${MODELPARAM_VALUE.DOMAIN_3_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_4_ID { MODELPARAM_VALUE.DOMAIN_4_ID PARAM_VALUE.DOMAIN_4_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_4_ID}] ${MODELPARAM_VALUE.DOMAIN_4_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_5_ID { MODELPARAM_VALUE.DOMAIN_5_ID PARAM_VALUE.DOMAIN_5_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_5_ID}] ${MODELPARAM_VALUE.DOMAIN_5_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_6_ID { MODELPARAM_VALUE.DOMAIN_6_ID PARAM_VALUE.DOMAIN_6_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_6_ID}] ${MODELPARAM_VALUE.DOMAIN_6_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_7_ID { MODELPARAM_VALUE.DOMAIN_7_ID PARAM_VALUE.DOMAIN_7_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_7_ID}] ${MODELPARAM_VALUE.DOMAIN_7_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_8_ID { MODELPARAM_VALUE.DOMAIN_8_ID PARAM_VALUE.DOMAIN_8_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_8_ID}] ${MODELPARAM_VALUE.DOMAIN_8_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_9_ID { MODELPARAM_VALUE.DOMAIN_9_ID PARAM_VALUE.DOMAIN_9_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_9_ID}] ${MODELPARAM_VALUE.DOMAIN_9_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_10_ID { MODELPARAM_VALUE.DOMAIN_10_ID PARAM_VALUE.DOMAIN_10_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_10_ID}] ${MODELPARAM_VALUE.DOMAIN_10_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_11_ID { MODELPARAM_VALUE.DOMAIN_11_ID PARAM_VALUE.DOMAIN_11_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_11_ID}] ${MODELPARAM_VALUE.DOMAIN_11_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_12_ID { MODELPARAM_VALUE.DOMAIN_12_ID PARAM_VALUE.DOMAIN_12_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_12_ID}] ${MODELPARAM_VALUE.DOMAIN_12_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_13_ID { MODELPARAM_VALUE.DOMAIN_13_ID PARAM_VALUE.DOMAIN_13_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_13_ID}] ${MODELPARAM_VALUE.DOMAIN_13_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_14_ID { MODELPARAM_VALUE.DOMAIN_14_ID PARAM_VALUE.DOMAIN_14_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_14_ID}] ${MODELPARAM_VALUE.DOMAIN_14_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_15_ID { MODELPARAM_VALUE.DOMAIN_15_ID PARAM_VALUE.DOMAIN_15_ID } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_15_ID}] ${MODELPARAM_VALUE.DOMAIN_15_ID}
}

proc update_MODELPARAM_VALUE.DOMAIN_0_MASK { MODELPARAM_VALUE.DOMAIN_0_MASK PARAM_VALUE.DOMAIN_0_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_0_MASK}] ${MODELPARAM_VALUE.DOMAIN_0_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_1_MASK { MODELPARAM_VALUE.DOMAIN_1_MASK PARAM_VALUE.DOMAIN_1_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_1_MASK}] ${MODELPARAM_VALUE.DOMAIN_1_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_2_MASK { MODELPARAM_VALUE.DOMAIN_2_MASK PARAM_VALUE.DOMAIN_2_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_2_MASK}] ${MODELPARAM_VALUE.DOMAIN_2_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_3_MASK { MODELPARAM_VALUE.DOMAIN_3_MASK PARAM_VALUE.DOMAIN_3_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_3_MASK}] ${MODELPARAM_VALUE.DOMAIN_3_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_4_MASK { MODELPARAM_VALUE.DOMAIN_4_MASK PARAM_VALUE.DOMAIN_4_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_4_MASK}] ${MODELPARAM_VALUE.DOMAIN_4_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_5_MASK { MODELPARAM_VALUE.DOMAIN_5_MASK PARAM_VALUE.DOMAIN_5_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_5_MASK}] ${MODELPARAM_VALUE.DOMAIN_5_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_6_MASK { MODELPARAM_VALUE.DOMAIN_6_MASK PARAM_VALUE.DOMAIN_6_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_6_MASK}] ${MODELPARAM_VALUE.DOMAIN_6_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_7_MASK { MODELPARAM_VALUE.DOMAIN_7_MASK PARAM_VALUE.DOMAIN_7_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_7_MASK}] ${MODELPARAM_VALUE.DOMAIN_7_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_8_MASK { MODELPARAM_VALUE.DOMAIN_8_MASK PARAM_VALUE.DOMAIN_8_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_8_MASK}] ${MODELPARAM_VALUE.DOMAIN_8_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_9_MASK { MODELPARAM_VALUE.DOMAIN_9_MASK PARAM_VALUE.DOMAIN_9_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_9_MASK}] ${MODELPARAM_VALUE.DOMAIN_9_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_10_MASK { MODELPARAM_VALUE.DOMAIN_10_MASK PARAM_VALUE.DOMAIN_10_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_10_MASK}] ${MODELPARAM_VALUE.DOMAIN_10_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_11_MASK { MODELPARAM_VALUE.DOMAIN_11_MASK PARAM_VALUE.DOMAIN_11_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_11_MASK}] ${MODELPARAM_VALUE.DOMAIN_11_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_12_MASK { MODELPARAM_VALUE.DOMAIN_12_MASK PARAM_VALUE.DOMAIN_12_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_12_MASK}] ${MODELPARAM_VALUE.DOMAIN_12_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_13_MASK { MODELPARAM_VALUE.DOMAIN_13_MASK PARAM_VALUE.DOMAIN_13_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_13_MASK}] ${MODELPARAM_VALUE.DOMAIN_13_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_14_MASK { MODELPARAM_VALUE.DOMAIN_14_MASK PARAM_VALUE.DOMAIN_14_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_14_MASK}] ${MODELPARAM_VALUE.DOMAIN_14_MASK}
}

proc update_MODELPARAM_VALUE.DOMAIN_15_MASK { MODELPARAM_VALUE.DOMAIN_15_MASK PARAM_VALUE.DOMAIN_15_MASK } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DOMAIN_15_MASK}] ${MODELPARAM_VALUE.DOMAIN_15_MASK}
}

