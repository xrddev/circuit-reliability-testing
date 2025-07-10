library IEEE;
use IEEE.std_logic_1164.all;
use work.Declarations.all;

entity tap_controler_FSM is port(		TCK : in std_logic;
													TMS : in std_logic;
													TRST : in std_logic;
													Capture_IR_Signal : out std_logic;
													Shift_DR_signal : out std_logic;
													Update_DR_signal : out std_logic;
													Shift_IR_signal : out std_logic;
													Update_IR_signal : out std_logic;
													Capture_DR_signal : out std_logic;
													Clock_DR_signal : out std_logic;
													Clock_IR_signal : out std_logic);
end entity;



architecture dataFlow of tap_controler_FSM is

signal state : state_type := TEST_LOGIC_RESET;

begin



	state_machine :
	process(TCK) is
	begin
		if TRST = '0' then state <= TEST_LOGIC_RESET; 
		elsif rising_edge(TCK) then
			case state is
						when TEST_LOGIC_RESET => if TMS = '1' then state <= TEST_LOGIC_RESET; else state <= RUN_TEST; 		end if;
						when RUN_TEST			=> if TMS = '1' then state <= SELECT_DR_SCAN; 	else state <= RUN_TEST; 		end if;
						when SELECT_DR_SCAN  => if TMS = '1' then state <= SELECT_IR_SCAN; 	else state <= CAPTURE_DR; 		end if;
						when CAPTURE_DR		=> if TMS = '1' then state <= EXIT_1_DR; 			else state <= SHIFT_DR; 		end if;
						when SHIFT_DR			=> if TMS = '1' then state <= EXIT_1_DR; 			else state <= SHIFT_DR; 		end if;
						when EXIT_1_DR			=> if TMS = '1' then state <= UPDATE_DR; 			else state <= PAUSE_DR; 		end if;
						when PAUSE_DR 			=> if TMS = '1' then state <= EXIT_2_DR; 			else state <= PAUSE_DR; 		end if;
					   when EXIT_2_DR 		=> if TMS = '1' then state <= UPDATE_DR; 			else state <= SHIFT_DR; 		end if;
						when UPDATE_DR			=> if TMS = '1' then state <= SELECT_DR_SCAN; 	else state <= RUN_TEST; 		end if;
						when SELECT_IR_SCAN 	=> if TMS = '1' then state <= TEST_LOGIC_RESET; else state <= CAPTURE_IR; 		end if;
						when CAPTURE_IR 		=> if TMS = '1' then state <= EXIT_1_IR ; 		else state <= SHIFT_IR; 		end if;
						when SHIFT_IR			=> if TMS = '1' then state <= EXIT_1_IR; 			else state <= SHIFT_IR; 		end if;
						when EXIT_1_IR			=> if TMS = '1' then state <= UPDATE_IR; 			else state <= PAUSE_IR; 		end if;
						when PAUSE_IR			=> if TMS = '1' then state <= EXIT_2_IR; 			else state <= PAUSE_IR; 		end if;
						when EXIT_2_IR			=> if TMS = '1' then state <= UPDATE_IR; 			else state <= SHIFT_IR; 		end if;
						when UPDATE_IR			=> if TMS = '1' then state <= SELECT_DR_SCAN; 	else state <= RUN_TEST; 		end if;
				end case;
			end if;
		end process;

	
		--Signals Logic
		
		Update_DR_signal <= '1' when state = UPDATE_DR else '0';
		Update_IR_signal <= '1' when state = UPDATE_IR else '0';
		
		Shift_DR_Signal <= '1' when state = SHIFT_DR else '0';
		Shift_IR_Signal <= '1' when state = SHIFT_IR else '0';
		
		Clock_DR_signal <= TCK when state = SHIFT_DR else '0';
		Clock_IR_signal <= TCK when state = SHIFT_IR else '0';
		
		Capture_DR_signal <= '1' when state = CAPTURE_DR or state = SHIFT_DR else '0';
		Capture_IR_Signal <= '1' when state = CAPTURE_IR or state = SHIFT_IR else '0';
		
end architecture;

