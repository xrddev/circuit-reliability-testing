LIBRARY ieee  ;
LIBRARY std  ;
USE ieee.std_logic_1164.all  ;
USE ieee.std_logic_arith.all  ;
USE ieee.std_logic_textio.all  ;
USE ieee.STD_LOGIC_UNSIGNED.all  ;
USE ieee.std_logic_unsigned.all  ;
USE std.textio.all  ;


entity TRCUT_WITH_LFSR_testbench is
end entity;




architecture testbench of TRCUT_WITH_LFSR_testbench is
   component TRCUT_with_LFSR is
       port (
           clock          : in std_logic;
           selected_mode  : in std_logic;
           serial_output  : out std_logic
       );
   end component;




   signal clock  : std_logic := '1';
   signal serial_output : std_logic := 'X';
   signal selected_mode : std_logic  := '1';




   type std_logic_vector_array is array (0 to 31) of std_logic_vector(3 downto 0);
   signal TRCUT_RESPONSES: std_logic_vector_array;



begin


   UUT : entity work.TRCUT_with_LFSR(noFault)
       port map (
           clock          => clock,
           selected_mode  => selected_mode,
           serial_output  => serial_output
       );


   clock <= not clock after 2.5 ns;




   -- scanTesting
   process is begin


       wait for 5.0 ns;


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
       wait;
   end process;
   -- Responses Capture
   process is begin
       wait for 30 ns;


       for i in 0 to 31 loop
           for j in 0 to 3 loop
               TRCUT_RESPONSES(i)(j) <= serial_output;
               wait for 5 ns;
           end loop;
           --ignore last one bit from serial
           wait for 5 ns;
       end loop;


       wait;
   end process;


end architecture;