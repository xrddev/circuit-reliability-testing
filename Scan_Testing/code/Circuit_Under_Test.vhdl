library IEEE;
use IEEE.std_logic_1164.all;


entity Circuit_Under_Test is port(  a : in std_logic;
                                     b : in std_logic;
                                     c : in std_logic;
                                     d : in std_logic;
                                     i : out std_logic;
                                     j : out std_logic);
end entity;


architecture dataFlow of Circuit_Under_Test is


   signal e, f, g, h : std_logic;


begin


   -- First Level --
   e <= a xor b;
   f <= c xor d;
   g <= a xor c;
   h <= b xor d;


   -- Second Level --
   i <= e and f;
   j <= g or h;


end architecture dataFlow;