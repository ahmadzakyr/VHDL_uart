----------------------------------------------------------------------------------
-- Engineer: AZR
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: 
-- Target Devices: xc7a35t
-- Tool Versions: 16.1
-- Description: core
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity tb_baud_gen is

end entity tb_baud_gen;	

architecture tb of tb_baud_gen is


    component baud_gen
        generic( BAUD_DIV   : std_logic_vector(6 downto 0) :=  "0000010");                  
        port(                            
                clk_i    : in std_logic;                                             
                rstn_i   : in std_logic;       
                baud_o   : out std_logic     
        );
    end component;

    signal s_clk    : std_logic;
    signal s_rstn   : std_logic;
    signal s_baud_i : std_logic;
    signal s_baud_o : std_logic;

begin


        DUT : baud_gen
        generic map( BAUD_DIV   => "0000010")               
        port map(                            
                clk_i   => s_clk,                                       
                rstn_i  => s_rstn, 
                baud_o  => s_baud_o    
        );
    
    process
    begin
        s_rstn <= '0';
        wait for 5000 ns;
        s_rstn <= '1';
        wait;
    end process;
    
    process
    begin
        s_clk <= '1';
        wait for 451 ns;
        s_clk <= '0';
        wait for 451 ns;
    end process;
    
    
    
end tb;