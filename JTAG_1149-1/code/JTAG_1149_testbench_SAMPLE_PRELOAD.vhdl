library IEEE;
use IEEE.std_logic_1164.all;
use work.Declarations.all;


entity JTAG_1149_testbench_SAMPLE_PRELOAD is
end JTAG_1149_testbench_SAMPLE_PRELOAD;

architecture testbench of JTAG_1149_testbench_SAMPLE_PRELOAD is

    component JTAG_1149
    port( 
        TDI : in std_logic;
        TDO : out std_logic;
        TCK : in std_logic;
        TMS : in std_logic;
        TRST : in std_logic;
        Device_Inputs : in std_logic_vector(3 downto 0);
        Device_Outputs : out std_logic_vector(1 downto 0)
    );
    end component;

	 
	 
    signal TDI , TDO, TMS: std_logic;
	 signal CURRENT_STATE : state_type;
	 signal TCK : std_logic := '1';
	 signal TRST : std_logic := '0';
	 
	 
	 
	 signal Device_Inputs : std_logic_vector(3 downto 0) := "0010";
    signal Device_Outputs : std_logic_vector(1 downto 0);



begin
   
	
    DUT: JTAG_1149
    port map (
        TDI => TDI,
        TDO => TDO,
        TCK => TCK,
        TMS => TMS,
        TRST => TRST,
        Device_Inputs => Device_Inputs,
        Device_Outputs => Device_Outputs
    );
	 
	 
	 TCK <= not TCK after 2.5 ns;
	 
	 process is 
	 begin
	 
	 wait for 2.5 ns;
	 TRST <= '0';
	 
	 
	 -- TEST LOGIC RESET 
	 TRST <= '1';
	 wait for 2.5 ns;
	 
	 
	 --Current State = Run Test - Idle
	 wait for 2.5 ns;
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 
	 --Current State = Select DR Scan
	 wait for 2.5 ns;
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 
	 --Current State = Select IR Scan
	 wait for 2.5 ns;
	 TMS <= '0'; 
	 wait for 2.5 ns;
	 
	 --Current State = Capture IR
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = Shift IR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = Shift IR
	 wait for 2.5 ns;
	 TMS <= '1';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = EXIT_1 IR
	 wait for 2.5 ns;
	 TDI <= 'X';
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 
	 --Current State = Update IR
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 
	 -- Current State = RUN TEST IDLE 
	 wait for 2.5 ns;
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Select DR Scan
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = Capture DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	  --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	  --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Shift DR
	 wait for 2.5 ns;
	 TMS <= '1';
	 TDI <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Exit 1 DR
	 wait for 2.5 ns;
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Update DR
	 wait for 2.5 ns;
	 TMS <= '1';
	 wait for 2.5 ns;
	 
	 --Current State = Select DR Scan
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = Capture DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 --Current State = SHIFT DR
	 wait for 2.5 ns;
	 TMS <= '0';
	 wait for 2.5 ns;
	 
	 
	 
	 
	 wait for 5*20 ns;
	 

	 
	 wait;

	 end process;
	
		
end architecture;



	 
