library IEEE;
use IEEE.std_logic_1164.all;


entity LFSR_8_BITS is
   port(clock:in std_logic;   q:out std_logic);
end;


architecture RTL of LFSR_8_BITS is
   signal LFSR: std_logic_vector(7 downto 0) := "01011100"; --random seed
begin
   process(clock)
       variable feedback: std_logic;
   begin
       if clock'EVENT and clock='1' then
           feedback := LFSR(7);
           LFSR(0) <= feedback;
           LFSR(1) <= LFSR(0);
           LFSR(2) <= LFSR(1) xor feedback;
           LFSR(3) <= LFSR(2) xor feedback;
           LFSR(4) <= LFSR(3) xor feedback;
           LFSR(5) <= LFSR(4);
           LFSR(6) <= LFSR(5);
           LFSR(7) <= LFSR(6);
       end if;
       q <= LFSR(7);
   end process;
end;