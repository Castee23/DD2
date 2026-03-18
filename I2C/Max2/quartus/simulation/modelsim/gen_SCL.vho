-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "03/17/2026 18:55:30"

-- 
-- Device: Altera EPM2210F324C5 Package FBGA324
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	gen_SCL IS
    PORT (
	clk : IN std_logic;
	nRst : IN std_logic;
	ena_SCL : IN std_logic;
	ena_out_SDA : BUFFER std_logic;
	ena_in_SDA : BUFFER std_logic;
	ena_stop_i2c : BUFFER std_logic;
	ena_start_i2c : BUFFER std_logic;
	SCL_up : BUFFER std_logic;
	SCL : INOUT std_logic
	);
END gen_SCL;

-- Design Ports Information
-- ena_SCL	=>  Location: PIN_A14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- clk	=>  Location: PIN_J6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- nRst	=>  Location: PIN_K6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- ena_out_SDA	=>  Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- ena_in_SDA	=>  Location: PIN_E11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- ena_stop_i2c	=>  Location: PIN_A13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- ena_start_i2c	=>  Location: PIN_F11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- SCL_up	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- SCL	=>  Location: PIN_D12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA


ARCHITECTURE structure OF gen_SCL IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_nRst : std_logic;
SIGNAL ww_ena_SCL : std_logic;
SIGNAL ww_ena_out_SDA : std_logic;
SIGNAL ww_ena_in_SDA : std_logic;
SIGNAL ww_ena_stop_i2c : std_logic;
SIGNAL ww_ena_start_i2c : std_logic;
SIGNAL ww_SCL_up : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~32COUT1_42\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~22COUT1_44\ : std_logic;
SIGNAL \Add0~10_combout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~2COUT1_48\ : std_logic;
SIGNAL \Add0~5_combout\ : std_logic;
SIGNAL \nRst~combout\ : std_logic;
SIGNAL \Add0~7\ : std_logic;
SIGNAL \Add0~7COUT1_50\ : std_logic;
SIGNAL \Add0~25_combout\ : std_logic;
SIGNAL \Equal4~0_combout\ : std_logic;
SIGNAL \Equal4~1_combout\ : std_logic;
SIGNAL \ena_SCL~combout\ : std_logic;
SIGNAL \ena_start_i2c~0_combout\ : std_logic;
SIGNAL \cnt_SCL[6]~0_combout\ : std_logic;
SIGNAL \Add0~12\ : std_logic;
SIGNAL \Add0~12COUT1_46\ : std_logic;
SIGNAL \Add0~15_combout\ : std_logic;
SIGNAL \Add0~17\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \LessThan0~1_combout\ : std_logic;
SIGNAL \LessThan0~2_combout\ : std_logic;
SIGNAL \cnt_SCL~2_combout\ : std_logic;
SIGNAL \Add0~32_cout0\ : std_logic;
SIGNAL \Add0~20_combout\ : std_logic;
SIGNAL \ena_out_SDA~0_combout\ : std_logic;
SIGNAL \ena_out_SDA~1_combout\ : std_logic;
SIGNAL \start~regout\ : std_logic;
SIGNAL \ena_in_SDA~1_combout\ : std_logic;
SIGNAL \ena_in_SDA~0_combout\ : std_logic;
SIGNAL \ena_in_SDA~2_combout\ : std_logic;
SIGNAL \ena_stop_i2c~0_combout\ : std_logic;
SIGNAL \ena_stop_i2c~1_combout\ : std_logic;
SIGNAL \SCL_up~0_combout\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \LessThan1~0_combout\ : std_logic;
SIGNAL \scl_glitch~regout\ : std_logic;
SIGNAL cnt_SCL : std_logic_vector(6 DOWNTO 0);
SIGNAL \ALT_INV_nRst~combout\ : std_logic;
SIGNAL \ALT_INV_ena_start_i2c~0_combout\ : std_logic;
SIGNAL \ALT_INV_ena_stop_i2c~1_combout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_nRst <= nRst;
ww_ena_SCL <= ena_SCL;
ena_out_SDA <= ww_ena_out_SDA;
ena_in_SDA <= ww_ena_in_SDA;
ena_stop_i2c <= ww_ena_stop_i2c;
ena_start_i2c <= ww_ena_start_i2c;
SCL_up <= ww_SCL_up;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_nRst~combout\ <= NOT \nRst~combout\;
\ALT_INV_ena_start_i2c~0_combout\ <= NOT \ena_start_i2c~0_combout\;
\ALT_INV_ena_stop_i2c~1_combout\ <= NOT \ena_stop_i2c~1_combout\;

-- Location: LC_X17_Y13_N1
\Add0~32\ : maxii_lcell
-- Equation(s):
-- \Add0~32_cout0\ = CARRY(((!cnt_SCL(0))))
-- \Add0~32COUT1_42\ = CARRY(((!cnt_SCL(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff33",
	operation_mode => "arithmetic",
	output_mode => "none",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~30\,
	cout0 => \Add0~32_cout0\,
	cout1 => \Add0~32COUT1_42\);

-- Location: LC_X17_Y13_N2
\Add0~20\ : maxii_lcell
-- Equation(s):
-- \Add0~20_combout\ = (cnt_SCL(1) $ ((\Add0~32_cout0\)))
-- \Add0~22\ = CARRY(((!\Add0~32_cout0\) # (!cnt_SCL(1))))
-- \Add0~22COUT1_44\ = CARRY(((!\Add0~32COUT1_42\) # (!cnt_SCL(1))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(1),
	cin0 => \Add0~32_cout0\,
	cin1 => \Add0~32COUT1_42\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~20_combout\,
	cout0 => \Add0~22\,
	cout1 => \Add0~22COUT1_44\);

-- Location: LC_X17_Y13_N3
\Add0~10\ : maxii_lcell
-- Equation(s):
-- \Add0~10_combout\ = (cnt_SCL(2) $ ((!\Add0~22\)))
-- \Add0~12\ = CARRY(((cnt_SCL(2) & !\Add0~22\)))
-- \Add0~12COUT1_46\ = CARRY(((cnt_SCL(2) & !\Add0~22COUT1_44\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "c30c",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(2),
	cin0 => \Add0~22\,
	cin1 => \Add0~22COUT1_44\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~10_combout\,
	cout0 => \Add0~12\,
	cout1 => \Add0~12COUT1_46\);

-- Location: LC_X17_Y13_N5
\Add0~0\ : maxii_lcell
-- Equation(s):
-- \Add0~0_combout\ = cnt_SCL(4) $ ((((!\Add0~17\))))
-- \Add0~2\ = CARRY((cnt_SCL(4) & ((!\Add0~17\))))
-- \Add0~2COUT1_48\ = CARRY((cnt_SCL(4) & ((!\Add0~17\))))

-- pragma translate_off
GENERIC MAP (
	cin_used => "true",
	lut_mask => "a50a",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(4),
	cin => \Add0~17\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~0_combout\,
	cout0 => \Add0~2\,
	cout1 => \Add0~2COUT1_48\);

-- Location: LC_X17_Y13_N6
\Add0~5\ : maxii_lcell
-- Equation(s):
-- \Add0~5_combout\ = (cnt_SCL(5) $ (((!\Add0~17\ & \Add0~2\) # (\Add0~17\ & \Add0~2COUT1_48\))))
-- \Add0~7\ = CARRY(((!\Add0~2\) # (!cnt_SCL(5))))
-- \Add0~7COUT1_50\ = CARRY(((!\Add0~2COUT1_48\) # (!cnt_SCL(5))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "3c3f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(5),
	cin => \Add0~17\,
	cin0 => \Add0~2\,
	cin1 => \Add0~2COUT1_48\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~5_combout\,
	cout0 => \Add0~7\,
	cout1 => \Add0~7COUT1_50\);

-- Location: PIN_K6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\nRst~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_nRst,
	combout => \nRst~combout\);

-- Location: LC_X15_Y13_N9
\cnt_SCL[5]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(5) = DFFEAS((((!\cnt_SCL[6]~0_combout\ & \Add0~5_combout\))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => \cnt_SCL[6]~0_combout\,
	datad => \Add0~5_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(5));

-- Location: LC_X17_Y13_N7
\Add0~25\ : maxii_lcell
-- Equation(s):
-- \Add0~25_combout\ = (((!\Add0~17\ & \Add0~7\) # (\Add0~17\ & \Add0~7COUT1_50\) $ (!cnt_SCL(6))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	cin_used => "true",
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datad => cnt_SCL(6),
	cin => \Add0~17\,
	cin0 => \Add0~7\,
	cin1 => \Add0~7COUT1_50\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~25_combout\);

-- Location: LC_X16_Y13_N3
\cnt_SCL[6]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(6) = DFFEAS(((!\cnt_SCL[6]~0_combout\ & ((\Add0~25_combout\)))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3300",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datab => \cnt_SCL[6]~0_combout\,
	datad => \Add0~25_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(6));

-- Location: LC_X16_Y13_N4
\Equal4~0\ : maxii_lcell
-- Equation(s):
-- \Equal4~0_combout\ = (!cnt_SCL(0) & (!cnt_SCL(2) & (!cnt_SCL(5) & !cnt_SCL(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datab => cnt_SCL(2),
	datac => cnt_SCL(5),
	datad => cnt_SCL(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Equal4~0_combout\);

-- Location: LC_X16_Y13_N5
\Equal4~1\ : maxii_lcell
-- Equation(s):
-- \Equal4~1_combout\ = (!cnt_SCL(1) & (!cnt_SCL(3) & (!cnt_SCL(6) & \Equal4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(1),
	datab => cnt_SCL(3),
	datac => cnt_SCL(6),
	datad => \Equal4~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Equal4~1_combout\);

-- Location: PIN_A14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\ena_SCL~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_ena_SCL,
	combout => \ena_SCL~combout\);

-- Location: LC_X16_Y13_N8
\ena_start_i2c~0\ : maxii_lcell
-- Equation(s):
-- \ena_start_i2c~0_combout\ = (cnt_SCL(0)) # ((cnt_SCL(1)) # ((\ena_SCL~combout\) # (!\LessThan0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "feff",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datab => cnt_SCL(1),
	datac => \ena_SCL~combout\,
	datad => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_start_i2c~0_combout\);

-- Location: LC_X16_Y13_N9
\cnt_SCL[6]~0\ : maxii_lcell
-- Equation(s):
-- \cnt_SCL[6]~0_combout\ = (\ena_SCL~combout\ & (((\LessThan0~2_combout\)))) # (!\ena_SCL~combout\ & ((\Equal4~1_combout\) # ((!\ena_start_i2c~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e2f3",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \Equal4~1_combout\,
	datab => \ena_SCL~combout\,
	datac => \LessThan0~2_combout\,
	datad => \ena_start_i2c~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cnt_SCL[6]~0_combout\);

-- Location: LC_X16_Y13_N7
\cnt_SCL[2]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(2) = DFFEAS((((\Add0~10_combout\ & !\cnt_SCL[6]~0_combout\))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => \Add0~10_combout\,
	datad => \cnt_SCL[6]~0_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(2));

-- Location: LC_X17_Y13_N4
\Add0~15\ : maxii_lcell
-- Equation(s):
-- \Add0~15_combout\ = cnt_SCL(3) $ ((((\Add0~12\))))
-- \Add0~17\ = CARRY(((!\Add0~12COUT1_46\)) # (!cnt_SCL(3)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "5a5f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(3),
	cin0 => \Add0~12\,
	cin1 => \Add0~12COUT1_46\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Add0~15_combout\,
	cout => \Add0~17\);

-- Location: LC_X16_Y13_N0
\cnt_SCL[3]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(3) = DFFEAS(((\Add0~15_combout\ & ((!\cnt_SCL[6]~0_combout\)))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datab => \Add0~15_combout\,
	datad => \cnt_SCL[6]~0_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(3));

-- Location: LC_X16_Y13_N1
\cnt_SCL[4]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(4) = DFFEAS(((\Add0~0_combout\ & ((!\cnt_SCL[6]~0_combout\)))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00cc",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datab => \Add0~0_combout\,
	datad => \cnt_SCL[6]~0_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(4));

-- Location: LC_X15_Y13_N3
\LessThan0~0\ : maxii_lcell
-- Equation(s):
-- \LessThan0~0_combout\ = ((cnt_SCL(5) & (cnt_SCL(3) & cnt_SCL(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(5),
	datac => cnt_SCL(3),
	datad => cnt_SCL(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \LessThan0~0_combout\);

-- Location: LC_X15_Y13_N0
\LessThan0~1\ : maxii_lcell
-- Equation(s):
-- \LessThan0~1_combout\ = (cnt_SCL(4) & (((cnt_SCL(6) & \LessThan0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(4),
	datac => cnt_SCL(6),
	datad => \LessThan0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \LessThan0~1_combout\);

-- Location: LC_X15_Y13_N1
\LessThan0~2\ : maxii_lcell
-- Equation(s):
-- \LessThan0~2_combout\ = ((\LessThan0~1_combout\ & ((cnt_SCL(1)) # (!cnt_SCL(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f500",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datac => cnt_SCL(1),
	datad => \LessThan0~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \LessThan0~2_combout\);

-- Location: LC_X15_Y13_N5
\cnt_SCL~2\ : maxii_lcell
-- Equation(s):
-- \cnt_SCL~2_combout\ = (\Equal4~1_combout\) # ((!cnt_SCL(0) & (!cnt_SCL(1) & \LessThan0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff10",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datab => cnt_SCL(1),
	datac => \LessThan0~1_combout\,
	datad => \Equal4~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cnt_SCL~2_combout\);

-- Location: LC_X16_Y13_N6
\cnt_SCL[0]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(0) = DFFEAS((!cnt_SCL(0) & ((\ena_SCL~combout\ & (!\LessThan0~2_combout\)) # (!\ena_SCL~combout\ & ((!\cnt_SCL~2_combout\))))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1013",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \LessThan0~2_combout\,
	datab => cnt_SCL(0),
	datac => \ena_SCL~combout\,
	datad => \cnt_SCL~2_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(0));

-- Location: LC_X16_Y13_N2
\cnt_SCL[1]\ : maxii_lcell
-- Equation(s):
-- cnt_SCL(1) = DFFEAS((((\Add0~20_combout\ & !\cnt_SCL[6]~0_combout\))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "00f0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => \Add0~20_combout\,
	datad => \cnt_SCL[6]~0_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => cnt_SCL(1));

-- Location: LC_X14_Y13_N5
\ena_out_SDA~0\ : maxii_lcell
-- Equation(s):
-- \ena_out_SDA~0_combout\ = ((cnt_SCL(1) & ((cnt_SCL(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => cnt_SCL(1),
	datad => cnt_SCL(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_out_SDA~0_combout\);

-- Location: LC_X14_Y13_N2
\ena_out_SDA~1\ : maxii_lcell
-- Equation(s):
-- \ena_out_SDA~1_combout\ = (\ena_out_SDA~0_combout\ & (\Equal4~0_combout\ & (cnt_SCL(6) & \ena_SCL~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ena_out_SDA~0_combout\,
	datab => \Equal4~0_combout\,
	datac => cnt_SCL(6),
	datad => \ena_SCL~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_out_SDA~1_combout\);

-- Location: LC_X15_Y13_N6
start : maxii_lcell
-- Equation(s):
-- \start~regout\ = DFFEAS(((\ena_SCL~combout\ & ((\start~regout\) # (\LessThan0~2_combout\)))), GLOBAL(\clk~combout\), GLOBAL(\nRst~combout\), , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datab => \ena_SCL~combout\,
	datac => \start~regout\,
	datad => \LessThan0~2_combout\,
	aclr => \ALT_INV_nRst~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \start~regout\);

-- Location: LC_X15_Y13_N4
\ena_in_SDA~1\ : maxii_lcell
-- Equation(s):
-- \ena_in_SDA~1_combout\ = (!cnt_SCL(0) & (cnt_SCL(1) & (\start~regout\ & cnt_SCL(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datab => cnt_SCL(1),
	datac => \start~regout\,
	datad => cnt_SCL(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_in_SDA~1_combout\);

-- Location: LC_X15_Y13_N7
\ena_in_SDA~0\ : maxii_lcell
-- Equation(s):
-- \ena_in_SDA~0_combout\ = (!cnt_SCL(6) & (!cnt_SCL(5) & (!cnt_SCL(3) & cnt_SCL(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(6),
	datab => cnt_SCL(5),
	datac => cnt_SCL(3),
	datad => cnt_SCL(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_in_SDA~0_combout\);

-- Location: LC_X15_Y13_N8
\ena_in_SDA~2\ : maxii_lcell
-- Equation(s):
-- \ena_in_SDA~2_combout\ = (\ena_in_SDA~1_combout\ & (((\ena_in_SDA~0_combout\ & \ena_SCL~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ena_in_SDA~1_combout\,
	datac => \ena_in_SDA~0_combout\,
	datad => \ena_SCL~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_in_SDA~2_combout\);

-- Location: LC_X17_Y13_N9
\ena_stop_i2c~0\ : maxii_lcell
-- Equation(s):
-- \ena_stop_i2c~0_combout\ = (cnt_SCL(0)) # ((cnt_SCL(1)) # ((cnt_SCL(4)) # (\ena_SCL~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(0),
	datab => cnt_SCL(1),
	datac => cnt_SCL(4),
	datad => \ena_SCL~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_stop_i2c~0_combout\);

-- Location: LC_X14_Y13_N1
\ena_stop_i2c~1\ : maxii_lcell
-- Equation(s):
-- \ena_stop_i2c~1_combout\ = ((cnt_SCL(6)) # ((\ena_stop_i2c~0_combout\))) # (!\LessThan0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fdfd",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \LessThan0~0_combout\,
	datab => cnt_SCL(6),
	datac => \ena_stop_i2c~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \ena_stop_i2c~1_combout\);

-- Location: LC_X15_Y13_N2
\SCL_up~0\ : maxii_lcell
-- Equation(s):
-- \SCL_up~0_combout\ = (((\start~regout\ & \Equal4~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \start~regout\,
	datad => \Equal4~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \SCL_up~0_combout\);

-- Location: PIN_J6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: LC_X17_Y13_N0
\LessThan1~0\ : maxii_lcell
-- Equation(s):
-- \LessThan1~0_combout\ = (cnt_SCL(4)) # ((cnt_SCL(3) & (cnt_SCL(1) & cnt_SCL(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f8f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => cnt_SCL(3),
	datab => cnt_SCL(1),
	datac => cnt_SCL(4),
	datad => cnt_SCL(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \LessThan1~0_combout\);

-- Location: LC_X17_Y13_N8
scl_glitch : maxii_lcell
-- Equation(s):
-- \scl_glitch~regout\ = DFFEAS(((!cnt_SCL(6) & ((!cnt_SCL(5)) # (!\LessThan1~0_combout\)))) # (!\ena_SCL~combout\), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5777",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \ena_SCL~combout\,
	datab => cnt_SCL(6),
	datac => \LessThan1~0_combout\,
	datad => cnt_SCL(5),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \scl_glitch~regout\);

-- Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\ena_out_SDA~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ena_out_SDA~1_combout\,
	oe => VCC,
	padio => ww_ena_out_SDA);

-- Location: PIN_E11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\ena_in_SDA~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ena_in_SDA~2_combout\,
	oe => VCC,
	padio => ww_ena_in_SDA);

-- Location: PIN_A13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\ena_stop_i2c~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_ena_stop_i2c~1_combout\,
	oe => VCC,
	padio => ww_ena_stop_i2c);

-- Location: PIN_F11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\ena_start_i2c~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \ALT_INV_ena_start_i2c~0_combout\,
	oe => VCC,
	padio => ww_ena_start_i2c);

-- Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\SCL_up~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \SCL_up~0_combout\,
	oe => VCC,
	padio => ww_SCL_up);

-- Location: PIN_D12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\SCL~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	open_drain_output => "true",
	operation_mode => "bidir")
-- pragma translate_on
PORT MAP (
	datain => \scl_glitch~regout\,
	oe => VCC,
	padio => SCL);
END structure;


