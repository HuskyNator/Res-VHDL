-- This code cannot work. Additionally, only few simulators support 2008 generics.

package log2lib is
	function log2 (a: integer) return integer;
end package;

package body log2lib is
  function log2 (a : integer) return integer is
    variable res : integer := 0;
  begin
    while a > 0 loop
      res := res + 1;
      a := a / 2;
    end loop;
    return res;
  end function;
end package body;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.log2lib.log2;

entity multiplexer is
  generic (
    type T;
    --type TA;
    -- It does not seem possible in VHDL to use a generic array in entity ports. In essence, generic libraries (not packages) would be necessary.
    L: integer);
  port (
    input : in TA (L - 1 downto 0);
    sel : in std_logic_vector(log2(L) - 1 downto 0);
	output: out T
  );
end entity;

architecture multiplexer of multiplexer is
begin
	output <= input(unsigned(sel));
end architecture;