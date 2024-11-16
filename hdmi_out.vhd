LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY UNISIM;
USE UNISIM.VComponents.all;

ENTITY hdmi_out IS
PORT (
    clk_250mhz : IN STD_LOGIC;
    HDMI_data_n : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    HDMI_data_p : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    HDMI_clk_n : OUT STD_LOGIC;
    HDMI_clk_p : OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE rtl OF hdmi_out IS
    CONSTANT FRAME_WIDTH   : INTEGER := 640;
    CONSTANT H_FRONT_PORCH : INTEGER := 16;
    CONSTANT H_BACK_PORCH  : INTEGER := 48;
    CONSTANT H_PULSE_WIDTH : INTEGER := 96;
    CONSTANT H_BLANK       : INTEGER := H_FRONT_PORCH + H_BACK_PORCH + H_PULSE_WIDTH;
    
    CONSTANT FRAME_HEIGHT    : INTEGER := 480;
    CONSTANT V_FRONT_PORCH   : INTEGER := 10;
    CONSTANT V_BACK_PORCH    : INTEGER := 33;
    CONSTANT V_PULSE_WIDTH   : INTEGER := 2;
    CONSTANT V_BLANK         : INTEGER := V_FRONT_PORCH + V_BACK_PORCH + V_PULSE_WIDTH;
        
    CONSTANT H_MAX : INTEGER := FRAME_WIDTH + H_BLANK;
    CONSTANT V_MAX : INTEGER := FRAME_HEIGHT + V_BLANK;

    SIGNAL channel_r, channel_g, channel_b : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL clk_25MHz, vsync, hsync, video_en : STD_LOGIC := '0';
    SIGNAL tmds_r_shift, tmds_g_shift, tmds_b_shift : STD_LOGIC := '0';
    SIGNAL tmds_r ,tmds_g, tmds_b: STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL h_active, v_active : STD_LOGIC := '0';
    
    -- Current position
    SIGNAL hpos : INTEGER RANGE 0 TO H_MAX := 0;
    SIGNAL vpos : INTEGER RANGE 0 TO V_MAX := 0;
BEGIN
    -- TMDS Channel Encoders
    TMDS_ENCODER_R: ENTITY WORK.tmds_encoder
    PORT MAP (  
        data => channel_r,
        clk => clk_25MHz,
        vde => video_en,
        c1 => '0',
        c0 => '0',
        q_out => tmds_r
    );
    TMDS_ENCODER_G: ENTITY WORK.tmds_encoder
    PORT MAP (  
        data => channel_g,
        clk => clk_25MHz,
        vde => video_en,
        c1 => '0',
        c0 => '0',
        q_out => tmds_g
    );
    TMDS_ENCODER_B: ENTITY WORK.tmds_encoder
    PORT MAP (  
        data => channel_b,
        clk => clk_25MHz,
        vde => video_en,
        c1 => vsync,
        c0 => hsync,
        q_out => tmds_b
    );

    -- Channel Shift Registers
    SHIFT_REGISTER_R: ENTITY WORK.shift_register
    GENERIC MAP(N => 10)
    PORT MAP (
        din => tmds_r,  
        clk => clk_250mhz,  
        dout => tmds_r_shift   
    );
    SHIFT_REGISTER_G: ENTITY WORK.shift_register
    GENERIC MAP(N => 10)
    PORT MAP (
        din => tmds_g,  
        clk => clk_250mhz,  
        dout => tmds_g_shift   
    );
    SHIFT_REGISTER_B: ENTITY WORK.shift_register
    GENERIC MAP(N => 10)
    PORT MAP (
        din => tmds_b,  
        clk => clk_250mhz,  
        dout => tmds_b_shift   
    );
 
    -- Create Differential Pairs (TMDS)
    OBUF_CLK : OBUFDS
    GENERIC MAP (IOSTANDARD =>"TMDS_33")
    PORT MAP (
        I => clk_25MHz,
        O => HDMI_clk_p,
        OB => HDMI_clk_n
    );
    OBUF_R : OBUFDS
    GENERIC MAP (IOSTANDARD =>"TMDS_33")
    PORT MAP (
        I => tmds_r_shift,
        O => HDMI_data_p(2),
        OB => HDMI_data_n(2)
    );
    OBUF_G : OBUFDS
    GENERIC MAP (IOSTANDARD =>"TMDS_33")
    PORT MAP (
        I => tmds_g_shift,
        O => HDMI_data_p(1),
        OB => HDMI_data_n(1)
    );
    OBUF_B : OBUFDS
    GENERIC MAP (IOSTANDARD =>"TMDS_33")
    PORT MAP (
        I => tmds_b_shift,
        O => HDMI_data_p(0),
        OB => HDMI_data_n(0)
    );

    -- Gerante 25MHz clock from 250MHz
    GENERATE_PIXEL_CLOCK:
    PROCESS(clk_250MHz)
      VARIABLE count: INTEGER RANGE 0 TO 5;
    BEGIN
        IF RISING_EDGE(clk_250MHz) THEN
            count := count + 1;
            IF (count = 5) THEN
                clk_25MHz <= NOT clk_25MHz;
                count := 0;
            END IF;
        END IF;
    END PROCESS;
    
    -- Horizontal Synchronization (at the of column) & Active
    HORIZONTAL_SYNC:
    PROCESS (clk_25MHz)
        -- Divide the screen in 6 strips for smooth transitions
        CONSTANT BAND_WIDTH : INTEGER := FRAME_WIDTH / 6;
        CONSTANT H_OFFSET : INTEGER := H_PULSE_WIDTH + H_BACK_PORCH;
    BEGIN           
        -- Calculate color values based in horizontal position:
            
        -- Red -> Yellow smooth transition
        IF (hpos >= H_OFFSET AND hpos < BAND_WIDTH + H_OFFSET) THEN
             -- Maximum Red
            channel_r <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
            -- Smoothly increase Green
            channel_g <= STD_LOGIC_VECTOR(TO_UNSIGNED(((hpos - H_OFFSET) * 255) / BAND_WIDTH, 8));
            
             -- Minimum Blue 
            channel_b <= (OTHERS => '0'); 
            
        -- Yellow -> Green smooth transition
        ELSIF (hpos < 2 * BAND_WIDTH + H_OFFSET) THEN
            -- Smoothly decrease Red
            channel_r <= STD_LOGIC_VECTOR(TO_UNSIGNED(255 - ((hpos - (BAND_WIDTH + H_OFFSET)) * 255) / BAND_WIDTH, 8));
             
             -- Maximum Green
            channel_g <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
             -- Minimum Blue 
            channel_b <= (OTHERS => '0');
        
        -- Green -> Cian smooth transition
        ELSIF (hpos < 3 * BAND_WIDTH + H_OFFSET) THEN
             -- Minimum Red 
            channel_r <= (OTHERS => '0');
            
             -- Maximum Green
            channel_g <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
             -- Smoothly increase Blue
            channel_b <= STD_LOGIC_VECTOR(TO_UNSIGNED(((hpos - (2 * BAND_WIDTH + H_OFFSET)) * 255) / BAND_WIDTH, 8));
                    
        -- Cian -> Blue smooth transition
        ELSIF (hpos < 4 * BAND_WIDTH + H_OFFSET) THEN
             -- Minimum Red
            channel_r <= (OTHERS => '0');
            
             -- Smoothly decrease Green
            channel_g <= STD_LOGIC_VECTOR(TO_UNSIGNED(255 - ((hpos - (3 * BAND_WIDTH + H_OFFSET)) * 255) / BAND_WIDTH, 8));
            
             -- Maximum Blue
            channel_b <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
        -- Blue -> Magenta smooth transition
        ELSIF (hpos < 5 * BAND_WIDTH + H_OFFSET) THEN
             -- Smoothly increase Red
            channel_r <= STD_LOGIC_VECTOR(TO_UNSIGNED(((hpos - (4 * BAND_WIDTH + H_OFFSET)) * 255) / BAND_WIDTH, 8));
            
             -- Minimum Green
            channel_g <= (OTHERS => '0');
            
             -- Maximum Blue
            channel_b <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
        -- Magenta -> Red smooth transition
        ELSIF (hpos < 6 * BAND_WIDTH + H_OFFSET) THEN
             -- Maximum Red
            channel_r <= STD_LOGIC_VECTOR(TO_UNSIGNED(255, 8));
            
             -- Minimum Green
            channel_g <= (OTHERS => '0');
            
             -- Smoothly decrease Blue
            channel_b <= STD_LOGIC_VECTOR(TO_UNSIGNED(255 - ((hpos - (5 * BAND_WIDTH + H_OFFSET)) * 255) / BAND_WIDTH, 8));
        
        -- Outside active area, all channels are off
        ELSE
            channel_r <= (OTHERS => '0');
            channel_g <= (OTHERS => '0');
            channel_b <= (OTHERS => '0');
        END IF;
                    
        IF (RISING_EDGE(clk_25MHz)) THEN
            hpos <= hpos + 1;
          
            IF (hpos = H_MAX) THEN
                hsync <= '0';
                hpos <= 0;
            ELSIF (hpos = H_PULSE_WIDTH) THEN
                hsync <='1';
            ELSIF (hpos = H_PULSE_WIDTH + H_BACK_PORCH) THEN
                h_active <= '1';
            ELSIF (hpos = H_PULSE_WIDTH + H_BACK_PORCH + FRAME_WIDTH) THEN
                h_active <= '0';
            END IF;
        END IF;
    END PROCESS;
    
    -- Vertical Synchronization (at the of line) & Active
    VERTICAL_SYNC:  
    PROCESS (hsync)
    BEGIN
        IF (FALLING_EDGE(hsync)) THEN
            vpos <= vpos + 1;
            IF (vpos = V_MAX) THEN
                vsync <= '0';
                vpos <= 0;
            ELSIF (vpos = V_PULSE_WIDTH) THEN
                vsync <='1';
            ELSIF (vpos = V_PULSE_WIDTH + V_BACK_PORCH) THEN
                v_active <= '1';
            ELSIF (vpos = V_PULSE_WIDTH + V_BACK_PORCH + FRAME_HEIGHT) THEN
                v_active <= '0';
            END IF;

        END IF;
    END PROCESS;

    video_en <= h_active AND v_active;

END ARCHITECTURE;
