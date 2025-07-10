library IEEE;
use IEEE.std_logic_1164.all;


entity TRCUT_WITH_MISR_TESTBENCH_NO_FAULT is
end entity;




architecture testbench of TRCUT_WITH_MISR_TESTBENCH_NO_FAULT is
   component TRCUT_WITH_MISR
   is port (selected_mode : in std_logic;
            clock : in std_logic;
            MISR_set: in std_logic;
            serial_output : out std_logic;
            error_Injection_mode : in std_logic);
   end component;


   signal clock, selected_mode , MISR_set , serial_output : std_logic := '1';
   signal error_Injection_mode : std_logic := '0';
   signal signature : std_logic_vector(15 downto 0);


begin


   DUT : entity work.TRCUT_WITH_MISR(NoFault)
       port map (
           selected_mode => selected_mode,
           clock => clock,
           MISR_set => MISR_set,
           serial_output => serial_output,
           error_Injection_mode => error_Injection_mode
       );


   clock <= not clock after 2.5 ns;




   -- scanTesting
   process is begin


       wait for 2.5 ns;
       MISR_set <= '0';
       wait for 2.5 ns;


       for i in 0 to 31 loop


           --load s1
           wait for 5 ns;


           --load s2;
           wait for 5 ns;


           -- load s3;
           wait for 5 ns;


           --load s4
           wait for 2.5 ns;


           selected_mode <= '0';
           wait for 5 ns;


           selected_mode <= '1';
           wait for 2.5 ns;




       end loop;


       -- scan chain last capture exit time
       wait for 4 * 5 ns ;




       -- signature capture
       for i in 0 to 15 loop
           signature(i) <= serial_output;
           wait for 5 ns;
       end loop;


       error_Injection_mode <= 'X';
       wait;
   end process;


end architecture;