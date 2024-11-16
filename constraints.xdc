##Clock signal
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { clk_125mhz }]; #IO_L11P_T1_SRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 [get_ports { clk_125mhz }];

##Switches
#set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports sw0]; #IO_L19N_T3_VREF_35 Sch=SW0
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports sw1]; #IO_L24P_T3_34 Sch=SW1
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports sw2]; #IO_L4N_T0_34 Sch=SW2
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports sw3]; #IO_L9P_T1_DQS_34 Sch=SW3

##Buttons
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports rst]; #IO_L20N_T3_34 Sch=BTN0
#set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports selecao]; #IO_L24N_T3_34 Sch=BTN1
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L18P_T2_34 Sch=BTN2
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { clk_cpu }]; #IO_L7P_T1_34 Sch=BTN3

##HDMI Signals
set_property -dict { PACKAGE_PIN H17   IOSTANDARD TMDS_33 } [get_ports HDMI_clk_n]; #IO_L13N_T2_MRCC_35 Sch=HDMI_CLK_N
set_property -dict { PACKAGE_PIN H16   IOSTANDARD TMDS_33 } [get_ports HDMI_clk_p]; #IO_L13P_T2_MRCC_35 Sch=HDMI_CLK_P
set_property -dict { PACKAGE_PIN D20   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_n[0] }]; #IO_L4N_T0_35 Sch=HDMI_D0_N
set_property -dict { PACKAGE_PIN D19   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_p[0] }]; #IO_L4P_T0_35 Sch=HDMI_D0_P
set_property -dict { PACKAGE_PIN B20   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_n[1] }]; #IO_L1N_T0_AD0N_35 Sch=HDMI_D1_N
set_property -dict { PACKAGE_PIN C20   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_p[1] }]; #IO_L1P_T0_AD0P_35 Sch=HDMI_D1_P
set_property -dict { PACKAGE_PIN A20   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_n[2] }]; #IO_L2N_T0_AD8N_35 Sch=HDMI_D2_N
set_property -dict { PACKAGE_PIN B19   IOSTANDARD TMDS_33 } [get_ports { HDMI_data_p[2] }]; #IO_L2P_T0_AD8P_35 Sch=HDMI_D2_P
#set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports hdmi_cec]; #IO_L5N_T0_AD9N_35 Sch=HDMI_CEC
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports hdmi_hpd]; #IO_L5P_T0_AD9P_35 Sch=HDMI_HPD
#set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports hdmi_out_en]; #IO_L6N_T0_VREF_35 Sch=HDMI_OUT_EN
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports hdmi_scl]; #IO_L16P_T2_35 Sch=HDMI_SCL
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports hdmi_sda]; #IO_L16N_T2_35 Sch=HDMI_SDA


##Pmod Header JA (XADC)
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { ja_p[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { ja_p[1] }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { ja_p[2] }]; #IO_L24P_T3_AD15P_35 Sch=JA3_R_P
#set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { ja_p[3] }]; #IO_L20P_T3_AD6P_35 Sch=JA4_R_P
#set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { ja_n[0] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N
#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { ja_n[1] }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N
#set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { ja_n[2] }]; #IO_L24N_T3_AD15N_35 Sch=JA3_R_N
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { ja_n[3] }]; #IO_L20N_T3_AD6N_35 Sch=JA4_R_N


##Pmod Header JB
set_property -dict { PACKAGE_PIN T20   IOSTANDARD LVCMOS33 } [get_ports { lcd_e }]; #IO_L15P_T2_DQS_34 Sch=JB1_p
set_property -dict { PACKAGE_PIN U20   IOSTANDARD LVCMOS33 } [get_ports { lcd_rw  }]; #IO_L15N_T2_DQS_34 Sch=JB1_N
set_property -dict { PACKAGE_PIN V20   IOSTANDARD LVCMOS33 } [get_ports { lcd_rs }]; #IO_L16P_T2_34 Sch=JB2_P
#set_property -dict { PACKAGE_PIN W20   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[0] }]; #IO_L16N_T2_34 Sch=JB2_N
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[3] }]; #IO_L17P_T2_34 Sch=JB3_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[2] }]; #IO_L17N_T2_34 Sch=JB3_N
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[1] }]; #IO_L22P_T3_34 Sch=JB4_P
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[0] }]; #IO_L22N_T3_34 Sch=JB4_N


##Pmod Header JC
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { keypad_row[0] }]; #IO_L10P_T1_34 Sch=JC1_P
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { keypad_row[1] }]; #IO_L10N_T1_34 Sch=JC1_N
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { keypad_row[2] }]; #IO_L1P_T0_34 Sch=JC2_P
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { keypad_row[3] }]; #IO_L1N_T0_34 Sch=JC2_N
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { keypad_col[0] }]; #IO_L8P_T1_34 Sch=JC3_P
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { keypad_col[1] }]; #IO_L8N_T1_34 Sch=JC3_N
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { keypad_col[2] }]; #IO_L2P_T0_34 Sch=JC4_P
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { keypad_col[3] }]; #IO_L2N_T0_34 Sch=JC4_N

set_property PULLDOWN TRUE [get_ports keypad_row[0]]
set_property PULLDOWN TRUE [get_ports keypad_row[1]]
set_property PULLDOWN TRUE [get_ports keypad_row[2]]
set_property PULLDOWN TRUE [get_ports keypad_row[3]]

##Pmod Header JD
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { jd_p[0] }]; #IO_L5P_T0_34 Sch=JD1_P
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { jd_n[0] }]; #IO_L5N_T0_34 Sch=JD1_N
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { jd_p[1] }]; #IO_L6P_T0_34 Sch=JD2_P
#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { jd_n[1] }]; #IO_L6N_T0_VREF_34 Sch=JD2_N
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { jd_p[2] }]; #IO_L11P_T1_SRCC_34 Sch=JD3_P
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { jd_n[2] }]; #IO_L11N_T1_SRCC_34 Sch=JD3_N
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { jd_p[3] }]; #IO_L21P_T3_DQS_34 Sch=JD4_P
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { jd_n[3] }]; #IO_L21N_T3_DQS_34 Sch=JD4_N


##Pmod Header JE
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { lcd_e }]; #IO_L4P_T0_34 Sch=JE1
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { lcd_rw }]; #IO_L18N_T2_34 Sch=JE2
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { lcd_rs }]; #IO_25_35 Sch=JE3
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { je[3] }]; #IO_L19P_T3_35 Sch=JE4
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[3] }]; #IO_L3N_T0_DQS_34 Sch=JE7
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[2] }]; #IO_L9N_T1_DQS_34 Sch=JE8
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[1] }]; #IO_L20P_T3_34 Sch=JE9
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { lcd_data[0] }]; #IO_L7N_T1_34 Sch=JE10


##USB-OTG overcurrent detect pin
#set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports otg_oc]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=OTG_OC


##VGA Connector
# set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[0] }]; #IO_L7P_T1_AD2P_35 Sch=VGA_R1
# set_property -dict { PACKAGE_PIN L20   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[1] }]; #IO_L9N_T1_DQS_AD3N_35 Sch=VGA_R2
# set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[2] }]; #IO_L17P_T2_AD5P_35 Sch=VGA_R3
# set_property -dict { PACKAGE_PIN G20   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[3] }]; #IO_L18N_T2_AD13N_35 Sch=VGA_R4
# set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[4] }]; #IO_L15P_T2_DQS_AD12P_35 Sch=VGA_R5
# set_property -dict { PACKAGE_PIN H18   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[0] }]; #IO_L14N_T2_AD4N_SRCC_35 Sch=VGA_G0
# set_property -dict { PACKAGE_PIN N20   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[1] }]; #IO_L14P_T2_SRCC_34 Sch=VGA_G1
# set_property -dict { PACKAGE_PIN L19   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[2] }]; #IO_L9P_T1_DQS_AD3P_35 Sch=VGA_G2
# set_property -dict { PACKAGE_PIN J19   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[3] }]; #IO_L10N_T1_AD11N_35 Sch=VGA_G3
# set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[4] }]; #IO_L17N_T2_AD5N_35 Sch=VGA_G4
# set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[5] }]; #IO_L15N_T2_DQS_AD12N_35 Sch=VGA=G5
# set_property -dict { PACKAGE_PIN P20   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[0] }]; #IO_L14N_T2_SRCC_34 Sch=VGA_B1
# set_property -dict { PACKAGE_PIN M20   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[1] }]; #IO_L7N_T1_AD2N_35 Sch=VGA_B2
# set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[2] }]; #IO_L10P_T1_AD11P_35 Sch=VGA_B3
# set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[3] }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=VGA_B4
# set_property -dict { PACKAGE_PIN G19   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[4] }]; #IO_L18P_T2_AD13P_35 Sch=VGA_B5
# set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports VGA_HS_O]; #IO_L13N_T2_MRCC_34 Sch=VGA_HS
# set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports VGA_VS_O]; #IO_0_34 Sch=VGA_VS