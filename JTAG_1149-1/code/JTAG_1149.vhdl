library IEEE;
use IEEE.std_logic_1164.all;
use work.Declarations.all;


entity JTAG_1149 is port(	TDI : in std_logic;
							TDO : out std_logic;
							TCK : in std_logic;
							TMS : in std_logic;
							TRST : in std_logic;
							Device_Inputs : in std_logic_vector(3 downto 0);
							Device_Outputs : out std_logic_vector(1 downto 0));
end entity;


architecture dataFlow of JTAG_1149 is
	 
	 component tap_controler_FSM
        port (
            TCK          : in std_logic;
            TMS          : in std_logic;
            TRST         : in std_logic;
            Capture_IR_Signal : out std_logic;
            Shift_DR_signal : out std_logic;
            Update_DR_signal : out std_logic;
            Shift_IR_signal : out std_logic;
            Update_IR_signal : out std_logic;
            Capture_DR_signal : out std_logic;
            Clock_DR_signal : out std_logic;
            Clock_IR_signal : out std_logic
        );
    end component;
	 
	 
	 component Decoder is
        port(
            Instruction: in std_logic_vector(1 downto 0);
            Mode : out std_logic;
            Data_Registers_Select : out std_logic;
				TDO_Select : out std_logic
        );
    end component;
	 
	 
	 	
	component IR_REG_JTAG is
        port (
            Reset: in std_logic;
            Shift_IR: in std_logic;
            Capture_Data: in std_logic;
            TDI: in std_logic;
            Clock_IR: in std_logic;
            Update_IR: in std_logic;
            TDO: out std_logic;
            Instruction_Bit: out std_logic
        );
    end component;
	 
	 component Circuit_Under_Test
        port(
            a : in std_logic;
            b : in std_logic;
            c : in std_logic;
            d : in std_logic;
            i : out std_logic;
            j : out std_logic
        );
    end component;
	 
	 
	  component BRCell_4bits_JTAG
        port(
            Parallel_Input   : in std_logic_vector(3 downto 0);
            Shift_DR         : in std_logic;
            Shift_IN         : in std_logic;
            Shift_OUT        : out std_logic;
            Clock_DR         : in std_logic;
            Update_DR        : in std_logic;
            Mode             : in std_logic;
            Parallel_Output  : out std_logic_vector(3 downto 0)
        );
    end component;
	 
	 
	  component BRCell_2bits_JTAG
        port(
            Parallel_Input   : in std_logic_vector(1 downto 0);
            Shift_DR         : in std_logic;
            Shift_IN         : in std_logic;
            Shift_OUT        : out std_logic;
            Clock_DR         : in std_logic;
            Update_DR        : in std_logic;
            Mode             : in std_logic;
            Parallel_Output  : out std_logic_vector(1 downto 0)
        );
    end component;
	 
	 
	 component IR_REG_2bits_JTAG
        port(
            Reset : in std_logic;
            Shift_IR : in std_logic;
            Capture_Data : in std_logic_vector(1 downto 0);
            TDI : in std_logic;
            Clock_IR : in std_logic;
            Update_IR : in std_logic;
            TDO : out std_logic;
            Instruction_Bits : out std_logic_vector(1 downto 0)
        );
    end component;
	 
	 
	 
	 component Bypass_REG_JTAG
        port (
            TDI : in std_logic;
            Capture_DR : in std_logic;
            Clock_DR : in std_logic;
            TDO : out std_logic
        );
    end component;

	 signal tap_Controler_FSM_State : state_type;
	 
	 signal boundary_Regs_1_outputs : std_logic_vector(3 downto 0);
	 
	 signal cut_i, cut_j : std_logic;
	 
	 signal boundary_regs_serial_connection : std_logic;
	 
	 signal current_state : state_type;
	 
	 
	 
	 --- to be connected somewhere 
	 signal Shift_DR, Clock_DR, Capture_IR ,Mode , Update_DR , tdo_boundary_regs: std_logic;
	 signal Shift_IR, Clock_IR, Capture_DR,  Update_IR , tdo_insruction_reg , tdo_bypass_reg :  std_logic;
	 signal data_in_decoder : std_logic_vector(1 downto 0);
	 signal instruction_parallel_load : std_logic_vector(1 downto 0);
	 signal mux_1 , data_Registers_Select : std_logic;
	 signal mux_2 , TDO_MUX_SELECT : std_logic;
	 signal CUT_Response : std_logic_vector(1 downto 0);

	 
	 

	 
begin

	
	
	Tap_Controler: tap_controler_FSM
        port map (
            TCK          => TCK,
            TMS          => TMS,
            TRST         => TRST,
            Capture_IR_Signal => Capture_IR,
				Shift_DR_signal => Shift_DR,
				Update_DR_signal => Update_DR,
				Shift_IR_signal => Shift_IR,
				Update_IR_signal => Update_IR,
				Capture_DR_signal => Capture_DR,
				Clock_DR_signal => Clock_DR,
				Clock_IR_signal => Clock_IR
        );
		  
		  
	
	 Boundary_Reg_1: BRCell_4bits_JTAG
        port map(
            Parallel_Input   => Device_Inputs,
            Shift_DR         => Shift_DR,
            Shift_IN         => TDI,
            Shift_OUT        => boundary_regs_serial_connection,
            Clock_DR         => Clock_DR,
            Update_DR        => Update_DR,
            Mode             => Mode,
            Parallel_Output  => boundary_Regs_1_outputs
        );
	
	CUT: entity work.Circuit_Under_Test(noFault) port map (
        a => boundary_Regs_1_outputs(0),
        b => boundary_Regs_1_outputs(1),
        c => boundary_Regs_1_outputs(2),
        d => boundary_Regs_1_outputs(3),
        i => cut_i,
        j => cut_j
    );
	 
	 
	 
	  Boundary_Reg_2: BRCell_2bits_JTAG
        port map(
            Parallel_Input   => CUT_Response,
            Shift_DR         => Shift_DR,
            Shift_IN         => boundary_regs_serial_connection,
            Shift_OUT        => tdo_boundary_regs,
            Clock_DR         => Clock_DR,
            Update_DR        => Update_DR,
            Mode             => Mode,
            Parallel_Output  => Device_Outputs
        );
		  
		  
		  
		Instruction_Register: IR_REG_2bits_JTAG
        port map (
            Reset => TRST,
            Shift_IR => Shift_IR,
            Capture_Data => instruction_parallel_load ,
            TDI => TDI,
            Clock_IR => Clock_IR,
            Update_IR => Update_IR,
            TDO => tdo_insruction_reg,
            Instruction_Bits => data_in_decoder
        );
		  
		  
		
	 
	Bypass_REG: Bypass_REG_JTAG
    port map (
        TDI => TDI,
        Capture_DR => Capture_DR,
        Clock_DR => Clock_DR,
        TDO => tdo_bypass_reg
    );
	 
	 
	 
	 Instructions_Decoder: Decoder port map (
        Instruction => data_in_decoder,
        Mode => Mode,
        Data_Registers_Select => Data_Registers_Select,
		  TDO_Select => TDO_MUX_SELECT
    );
	 
	 
	 
	 mux_1 <= tdo_boundary_regs 	when data_Registers_Select = '1' else
				 tdo_bypass_reg 		when data_Registers_Select = '0' else
				 'X'						when data_Registers_Select = 'X';
				 
	
	mux_2 <= tdo_insruction_reg when TDO_MUX_SELECT = '1' else
				mux_1 				 when TDO_MUX_SELECT = '0' else
				'X'					 when TDO_MUX_SELECT = 'X';

		
	TDO <= mux_2;
	
	CUT_Response <= cut_j & cut_i;

end architecture;


