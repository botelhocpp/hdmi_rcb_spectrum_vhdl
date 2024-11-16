LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY testbench_board IS
PORT (
    clk_125mhz : IN STD_LOGIC;
    HDMI_data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    HDMI_data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    HDMI_clk_n : OUT STD_LOGIC;
    HDMI_clk_p : OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE rtl OF testbench_board IS
    SIGNAL clk_250mhz, locked : STD_LOGIC;
BEGIN
    CLK_DOUBLER : ENTITY WORK.clk_doubler
    PORT MAP (
        clk_in => clk_125mhz,
        reset => '0',
        clk_out => clk_250mhz,
        locked => locked
    );
    HDMI_OUT_UUT: ENTITY WORK.hdmi_out
    PORT MAP (
        clk_250mhz => clk_250mhz,
        HDMI_data_n => HDMI_data_n,
        HDMI_data_p => HDMI_data_p,
        HDMI_clk_n => HDMI_clk_n,
        HDMI_clk_p => HDMI_clk_p
    );
    
END ARCHITECTURE;