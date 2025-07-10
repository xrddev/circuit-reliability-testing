LIBRARY ieee  ;
LIBRARY std  ;
USE ieee.std_logic_1164.all  ;
USE ieee.std_logic_arith.all  ;
USE ieee.std_logic_textio.all  ;
USE ieee.STD_LOGIC_UNSIGNED.all  ;
USE ieee.std_logic_unsigned.all  ;
USE std.textio.all  ;


entity scan_testing_testbench is
end entity;




architecture testbench of scan_testing_testbench is


   component Test_Ready_Circuit_Under_Test is
       port(
           clock         : in std_logic;
           serial_input    : in std_logic;
           selected_mode   : in std_logic;
           serial_output   : out std_logic
       );
   end component;


   signal serial_input, selected_mode, serial_output  : std_logic := 'X';
   signal clock : std_logic := '1';


   type std_logic_vector_array is array (0 to 15) of std_logic_vector(3 downto 0);
   signal truth_table : std_logic_vector_array;


   type std_logic_vector_array1 is array (0 to 15) of std_logic_vector(3 downto 0);
   signal serial_output_log : std_logic_vector_array1;


   signal tb_line: std_logic_vector(3 downto 0) := "0000";


   signal first_execution : boolean := true;


   signal correct_circuit_output : std_logic := 'X';


   signal test_bit : std_logic;


   signal a,b,c,d,e,f,g,h,ii,j : std_logic := 'X';


begin


   DUT : Test_Ready_Circuit_Under_Test
       port map (
           clock          => clock,
           serial_input   => serial_input,
           selected_mode  => selected_mode,
           serial_output  => serial_output);


   clock <= not clock after 2.5 ns;


   process is
   begin




       if first_execution then first_execution <= false;




           -- truth table initialization
           for i in 0 to 15 loop
               truth_table(i) <= tb_line;
               tb_line <= tb_line + '1';
               wait for 5 ns;
           end loop;




           -- Checking serial is working
           wait for 2.5 ns;
           serial_input <= '0';
           selected_mode <= '1';
           wait for 5 ns;




           serial_input <= not serial_input;
           wait for 5 ns;


           serial_input <= not serial_input;
           wait for 5 ns;


           serial_input <= not serial_input;
           wait for 5 ns;


           serial_input <= 'X';
           wait for 5 ns;


           -- Scan  Testing
           for i in 0 to 15 loop
               for j in 0 to 3 loop
                   serial_input <= truth_table(i)(j);
                   wait for 5 ns;
               end loop;
               selected_mode <= '0';
               wait for 5 ns;
               selected_mode <= '1';
           end loop;


           serial_input <= 'X';




       else
           wait for 5 ns;
       end if;
       wait;
   end process;
  
   process is
   begin


       wait for 135 ns;


       -- serial_output_log_fill
       for i in 0 to 15 loop
           for j in 0 to 3 loop
               serial_output_log(i)(j) <= serial_output;
               wait for 5 ns;
           end loop;
           --ignore last one bit from serial
           wait for 5 ns;
       end loop;




       --- results confirm


       for i in 0 to 15 loop
           a <= truth_table(i)(3);
           b <= truth_table(i)(2);
           c <= truth_table(i)(1);
           d <= truth_table(i)(0);


           wait for 5 ns;


           e <= a xor b;
           f <= c xor d;
           g <= a xor c;
           h <= b xor d;


           wait for 5 ns;


           ii <= e and f;
           j <= g or h;


           wait for 5 ns;




           if (serial_output_log(i)(3) = j) and (serial_output_log(i)(2) = ii) then
               correct_circuit_output <= '1';
           else
               correct_circuit_output <= '0';
           end if;


           wait for 5 ns;
       end loop;


       correct_circuit_output <= 'X';
       wait;
   end process;
  
end architecture;