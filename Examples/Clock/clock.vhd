library ieee;
use ieee.std_logic_1164.all;

entity clock is
  generic (halftime : time := 5 ns);
  port (clk : inout std_logic := '0');
end entity clock;

architecture clock of clock is
begin
  clk <= not clk after halftime;
end architecture;