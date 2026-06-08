// Verilog for neutral 3D_TFT standard-cell library

// type: AND2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AND2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	and (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AND2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	and (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AND2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	and (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND3_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AND3_X1RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	and (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND3_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AND3_X2RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	and (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND3_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AND3_X4RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	and (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND4_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AND4_X1RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	and (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND4_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AND4_X2RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	and (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AND4_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AND4_X4RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	and (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI211_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI211_X1RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A2 & ~C))
			(B => Y) = 0;
		if ((~A1 & A2 & ~C))
			(B => Y) = 0;
		ifnone (B => Y) = 0;
		if ((~A2 & ~B))
			(C => Y) = 0;
		if ((~A1 & A2 & ~B))
			(C => Y) = 0;
		ifnone (C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI211_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI211_X2RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A2 & ~C))
			(B => Y) = 0;
		if ((~A1 & A2 & ~C))
			(B => Y) = 0;
		ifnone (B => Y) = 0;
		if ((~A2 & ~B))
			(C => Y) = 0;
		if ((~A1 & A2 & ~B))
			(C => Y) = 0;
		ifnone (C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI211_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI211_X4RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A2 & ~C))
			(B => Y) = 0;
		if ((~A1 & A2 & ~C))
			(B => Y) = 0;
		ifnone (B => Y) = 0;
		if ((~A2 & ~B))
			(C => Y) = 0;
		if ((~A1 & A2 & ~B))
			(C => Y) = 0;
		ifnone (C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI21_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI21_X1RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A1 & A2))
			(B => Y) = 0;
		if (~A2)
			(B => Y) = 0;
		ifnone (B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI21_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI21_X2RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A1 & A2))
			(B => Y) = 0;
		if (~A2)
			(B => Y) = 0;
		ifnone (B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI21_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI21_X4RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	and (int_fwire_0, A1, A2);
	or (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		if ((~A1 & A2))
			(B => Y) = 0;
		if (~A2)
			(B => Y) = 0;
		ifnone (B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI22_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI22_X1RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	and (int_fwire_0, B1, B2);
	and (int_fwire_1, A1, A2);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		if ((A2 & ~B2))
			(A1 => Y) = 0;
		if ((A2 & ~B1 & B2))
			(A1 => Y) = 0;
		ifnone (A1 => Y) = 0;
		if ((A1 & ~B2))
			(A2 => Y) = 0;
		if ((A1 & ~B1 & B2))
			(A2 => Y) = 0;
		ifnone (A2 => Y) = 0;
		if ((~A2 & B2))
			(B1 => Y) = 0;
		if ((~A1 & A2 & B2))
			(B1 => Y) = 0;
		ifnone (B1 => Y) = 0;
		if ((~A2 & B1))
			(B2 => Y) = 0;
		if ((~A1 & A2 & B1))
			(B2 => Y) = 0;
		ifnone (B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI22_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI22_X2RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	and (int_fwire_0, B1, B2);
	and (int_fwire_1, A1, A2);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		if ((A2 & ~B2))
			(A1 => Y) = 0;
		if ((A2 & ~B1 & B2))
			(A1 => Y) = 0;
		ifnone (A1 => Y) = 0;
		if ((A1 & ~B2))
			(A2 => Y) = 0;
		if ((A1 & ~B1 & B2))
			(A2 => Y) = 0;
		ifnone (A2 => Y) = 0;
		if ((~A2 & B2))
			(B1 => Y) = 0;
		if ((~A1 & A2 & B2))
			(B1 => Y) = 0;
		ifnone (B1 => Y) = 0;
		if ((~A2 & B1))
			(B2 => Y) = 0;
		if ((~A1 & A2 & B1))
			(B2 => Y) = 0;
		ifnone (B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: AOI22_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module AOI22_X4RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	and (int_fwire_0, B1, B2);
	and (int_fwire_1, A1, A2);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		if ((A2 & ~B2))
			(A1 => Y) = 0;
		if ((A2 & ~B1 & B2))
			(A1 => Y) = 0;
		ifnone (A1 => Y) = 0;
		if ((A1 & ~B2))
			(A2 => Y) = 0;
		if ((A1 & ~B1 & B2))
			(A2 => Y) = 0;
		ifnone (A2 => Y) = 0;
		if ((~A2 & B2))
			(B1 => Y) = 0;
		if ((~A1 & A2 & B2))
			(B1 => Y) = 0;
		ifnone (B1 => Y) = 0;
		if ((~A2 & B1))
			(B2 => Y) = 0;
		if ((~A1 & A2 & B1))
			(B2 => Y) = 0;
		ifnone (B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X1PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X1RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X2PC_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X2PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X2RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X4PC_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X4PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: BUF_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module BUF_X4RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: CLKBUF_F2X2PC_T5 
`timescale 1ns/10ps
`celldefine
module CLKBUF_F2X2PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: CLKBUF_F4X2PC_T5 
`timescale 1ns/10ps
`celldefine
module CLKBUF_F4X2PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: CLKBUF_X2PC_T5 
`timescale 1ns/10ps
`celldefine
module CLKBUF_X2PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: CLKBUF_X8PC_T5 
`timescale 1ns/10ps
`celldefine
module CLKBUF_X8PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DFFC_F2X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DFFC_F2X1PC_T5 (Q, QN, CLR, D, CLK);
	output Q, QN;
	input CLR, D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_IQb, xcr_0;

	altos_dff_r_err (xcr_0, delayed_CLK, delayed_D, CLR);
	altos_dff_r (int_fwire_IQ, notifier, delayed_CLK, delayed_D, CLR, xcr_0);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(posedge CLR => (Q+:1'b0)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		(posedge CLR => (QN-:1'b0)) = 0;
		(posedge CLK => (QN-:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (negedge CLR, posedge CLK, 0, notifier);
		$hold (posedge CLK, negedge CLR, 0, notifier);
		$width (posedge CLR, 0, 0, notifier);
		$width (posedge CLK, 0, 0, notifier);
		$width (negedge CLK, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: DFFC_F4X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DFFC_F4X1PC_T5 (Q, QN, CLR, D, CLK);
	output Q, QN;
	input CLR, D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_IQb, xcr_0;

	altos_dff_r_err (xcr_0, delayed_CLK, delayed_D, CLR);
	altos_dff_r (int_fwire_IQ, notifier, delayed_CLK, delayed_D, CLR, xcr_0);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(posedge CLR => (Q+:1'b0)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		(posedge CLR => (QN-:1'b0)) = 0;
		(posedge CLK => (QN-:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (negedge CLR, posedge CLK, 0, notifier);
		$hold (posedge CLK, negedge CLR, 0, notifier);
		$width (posedge CLR, 0, 0, notifier);
		$width (posedge CLK, 0, 0, notifier);
		$width (negedge CLK, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: DFFC_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DFFC_X1PC_T5 (Q, QN, CLR, D, CLK);
	output Q, QN;
	input CLR, D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_IQb, xcr_0;

	altos_dff_r_err (xcr_0, delayed_CLK, delayed_D, CLR);
	altos_dff_r (int_fwire_IQ, notifier, delayed_CLK, delayed_D, CLR, xcr_0);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(posedge CLR => (Q+:1'b0)) = 0;
		(posedge CLK => (Q+:D)) = 0;
		(posedge CLR => (QN-:1'b0)) = 0;
		(posedge CLK => (QN-:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$recovery (negedge CLR, posedge CLK, 0, notifier);
		$hold (posedge CLK, negedge CLR, 0, notifier);
		$width (posedge CLR, 0, 0, notifier);
		$width (posedge CLK, 0, 0, notifier);
		$width (negedge CLK, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: DFF_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DFF_X1PC_T5 (Q, QN, D, CLK);
	output Q, QN;
	input D, CLK;
	reg notifier;
	wire delayed_D, delayed_CLK;

	// Function
	wire int_fwire_IQ, int_fwire_IQb, xcr_0;

	altos_dff_err (xcr_0, delayed_CLK, delayed_D);
	altos_dff (int_fwire_IQ, notifier, delayed_CLK, delayed_D, xcr_0);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(posedge CLK => (Q+:D)) = 0;
		(posedge CLK => (QN-:D)) = 0;
		$setuphold (posedge CLK, posedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$setuphold (posedge CLK, negedge D, 0, 0, notifier,,, delayed_CLK, delayed_D);
		$width (posedge CLK, 0, 0, notifier);
		$width (negedge CLK, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: DLY1_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DLY1_X1PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DLY1_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module DLY1_X1RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DLY2_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DLY2_X1PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DLY2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module DLY2_X1RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DLY4_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module DLY4_X1PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: DLY4_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module DLY4_X1RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	buf (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: HA_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module HA_X1RL_T5 (CO, S, A, B);
	output CO, S;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	and (CO, A, B);
	not (A__bar, A);
	and (int_fwire_0, A__bar, B);
	not (B__bar, B);
	and (int_fwire_1, A, B__bar);
	or (S, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => CO) = 0;
		(B => CO) = 0;
		if (B)
			(A => S) = 0;
		ifnone (A => S) = 0;
		if (A)
			(B => S) = 0;
		ifnone (B => S) = 0;
	endspecify
endmodule
`endcelldefine

// type: HA_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module HA_X2RL_T5 (CO, S, A, B);
	output CO, S;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	and (CO, A, B);
	not (A__bar, A);
	and (int_fwire_0, A__bar, B);
	not (B__bar, B);
	and (int_fwire_1, A, B__bar);
	or (S, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => CO) = 0;
		(B => CO) = 0;
		if (B)
			(A => S) = 0;
		ifnone (A => S) = 0;
		if (A)
			(B => S) = 0;
		ifnone (B => S) = 0;
	endspecify
endmodule
`endcelldefine

// type: HA_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module HA_X4RL_T5 (CO, S, A, B);
	output CO, S;
	input A, B;

	// Function
	wire A__bar, B__bar, int_fwire_0;
	wire int_fwire_1;

	and (CO, A, B);
	not (A__bar, A);
	and (int_fwire_0, A__bar, B);
	not (B__bar, B);
	and (int_fwire_1, A, B__bar);
	or (S, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => CO) = 0;
		(B => CO) = 0;
		if (B)
			(A => S) = 0;
		ifnone (A => S) = 0;
		if (A)
			(B => S) = 0;
		ifnone (B => S) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module INV_X1PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module INV_X1RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X2PC_T5 
`timescale 1ns/10ps
`celldefine
module INV_X2PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module INV_X2RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X4PC_T5 
`timescale 1ns/10ps
`celldefine
module INV_X4PC_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: INV_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module INV_X4RL_T5 (Y, A);
	output Y;
	input A;

	// Function
	not (Y, A);

	// Timing
	specify
		(A => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: LAT_X1PC_T5 
`timescale 1ns/10ps
`celldefine
module LAT_X1PC_T5 (Q, QN, D, E);
	output Q, QN;
	input D, E;
	reg notifier;
	wire delayed_D, delayed_E;

	// Function
	wire int_fwire_IQ, int_fwire_IQb;

	altos_latch (int_fwire_IQ, notifier, delayed_E, delayed_D);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(D => Q) = 0;
		(posedge E => (Q+:D)) = 0;
		(D => QN) = 0;
		(posedge E => (QN-:D)) = 0;
		$setuphold (negedge E, posedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$setuphold (negedge E, negedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$width (posedge E, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: LAT_X2PC_T5 
`timescale 1ns/10ps
`celldefine
module LAT_X2PC_T5 (Q, QN, D, E);
	output Q, QN;
	input D, E;
	reg notifier;
	wire delayed_D, delayed_E;

	// Function
	wire int_fwire_IQ, int_fwire_IQb;

	altos_latch (int_fwire_IQ, notifier, delayed_E, delayed_D);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(D => Q) = 0;
		(posedge E => (Q+:D)) = 0;
		(D => QN) = 0;
		(posedge E => (QN-:D)) = 0;
		$setuphold (negedge E, posedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$setuphold (negedge E, negedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$width (posedge E, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: LAT_X4PC_T5 
`timescale 1ns/10ps
`celldefine
module LAT_X4PC_T5 (Q, QN, D, E);
	output Q, QN;
	input D, E;
	reg notifier;
	wire delayed_D, delayed_E;

	// Function
	wire int_fwire_IQ, int_fwire_IQb;

	altos_latch (int_fwire_IQ, notifier, delayed_E, delayed_D);
	buf (Q, int_fwire_IQ);
	not (int_fwire_IQb, int_fwire_IQ);
	buf (QN, int_fwire_IQb);

	// Timing
	specify
		(D => Q) = 0;
		(posedge E => (Q+:D)) = 0;
		(D => QN) = 0;
		(posedge E => (QN-:D)) = 0;
		$setuphold (negedge E, posedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$setuphold (negedge E, negedge D, 0, 0, notifier,,, delayed_E, delayed_D);
		$width (posedge E, 0, 0, notifier);
	endspecify
endmodule
`endcelldefine

// type: MX2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module MX2_X1RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: MX2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module MX2_X2RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: MX2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module MX2_X4RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: MXI2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module MXI2_X1RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: MXI2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module MXI2_X2RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: MXI2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module MXI2_X4RL_T5 (Y, A, B, S);
	output Y;
	input A, B, S;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;
	wire S__bar;

	and (int_fwire_0, B, S);
	not (S__bar, S);
	and (int_fwire_1, A, S__bar);
	or (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A => Y) = 0;
		(B => Y) = 0;
		(posedge S => (Y:S)) = 0;
		(negedge S => (Y:S)) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND2_X0P7RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND2_X0P7RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND3_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND3_X1RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND3_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND3_X2RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND3_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND3_X4RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND4_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND4_X1RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2, A3, A4);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NAND4_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NAND4_X2RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	wire int_fwire_0;

	and (int_fwire_0, A1, A2, A3, A4);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR3_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR3_X1RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR3_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR3_X2RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR3_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR3_X4RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR4_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR4_X1RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3, A4);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR4_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR4_X2RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3, A4);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: NOR4_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module NOR4_X4RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	wire int_fwire_0;

	or (int_fwire_0, A1, A2, A3, A4);
	not (Y, int_fwire_0);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI211_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI211_X1RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI211_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI211_X2RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI211_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI211_X4RL_T5 (Y, A1, A2, B, C);
	output Y;
	input A1, A2, B, C;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B, C);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
		(C => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI21_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI21_X1RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI21_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI21_X2RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI21_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI21_X4RL_T5 (Y, A1, A2, B);
	output Y;
	input A1, A2, B;

	// Function
	wire int_fwire_0, int_fwire_1;

	or (int_fwire_0, A1, A2);
	and (int_fwire_1, int_fwire_0, B);
	not (Y, int_fwire_1);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI22_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI22_X1RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	or (int_fwire_0, B1, B2);
	or (int_fwire_1, A1, A2);
	and (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B1 => Y) = 0;
		(B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI22_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI22_X2RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	or (int_fwire_0, B1, B2);
	or (int_fwire_1, A1, A2);
	and (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B1 => Y) = 0;
		(B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OAI22_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OAI22_X4RL_T5 (Y, A1, A2, B1, B2);
	output Y;
	input A1, A2, B1, B2;

	// Function
	wire int_fwire_0, int_fwire_1, int_fwire_2;

	or (int_fwire_0, B1, B2);
	or (int_fwire_1, A1, A2);
	and (int_fwire_2, int_fwire_1, int_fwire_0);
	not (Y, int_fwire_2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(B1 => Y) = 0;
		(B2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OR2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	or (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OR2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	or (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OR2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	or (Y, A1, A2);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR3_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OR3_X1RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	or (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR3_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OR3_X2RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	or (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR3_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OR3_X4RL_T5 (Y, A1, A2, A3);
	output Y;
	input A1, A2, A3;

	// Function
	or (Y, A1, A2, A3);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR4_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module OR4_X1RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	or (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR4_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module OR4_X2RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	or (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: OR4_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module OR4_X4RL_T5 (Y, A1, A2, A3, A4);
	output Y;
	input A1, A2, A3, A4;

	// Function
	or (Y, A1, A2, A3, A4);

	// Timing
	specify
		(A1 => Y) = 0;
		(A2 => Y) = 0;
		(A3 => Y) = 0;
		(A4 => Y) = 0;
	endspecify
endmodule
`endcelldefine

// type: TIEHI_T5 
`timescale 1ns/10ps
`celldefine
module TIEHI_T5 (Y);
	output Y;

	// Function
	buf (Y, 1'b1);

	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type: TIELO_T5 
`timescale 1ns/10ps
`celldefine
module TIELO_T5 (Y);
	output Y;

	// Function
	buf (Y, 1'b0);

	// Timing
	specify
	endspecify
endmodule
`endcelldefine

// type: XNOR2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module XNOR2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	and (int_fwire_0, A1, A2);
	not (A2__bar, A2);
	not (A1__bar, A1);
	and (int_fwire_1, A1__bar, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine

// type: XNOR2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module XNOR2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	and (int_fwire_0, A1, A2);
	not (A2__bar, A2);
	not (A1__bar, A1);
	and (int_fwire_1, A1__bar, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine

// type: XNOR2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module XNOR2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	and (int_fwire_0, A1, A2);
	not (A2__bar, A2);
	not (A1__bar, A1);
	and (int_fwire_1, A1__bar, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine

// type: XOR2_X1RL_T5 
`timescale 1ns/10ps
`celldefine
module XOR2_X1RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	not (A1__bar, A1);
	and (int_fwire_0, A1__bar, A2);
	not (A2__bar, A2);
	and (int_fwire_1, A1, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine

// type: XOR2_X2RL_T5 
`timescale 1ns/10ps
`celldefine
module XOR2_X2RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	not (A1__bar, A1);
	and (int_fwire_0, A1__bar, A2);
	not (A2__bar, A2);
	and (int_fwire_1, A1, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine

// type: XOR2_X4RL_T5 
`timescale 1ns/10ps
`celldefine
module XOR2_X4RL_T5 (Y, A1, A2);
	output Y;
	input A1, A2;

	// Function
	wire A1__bar, A2__bar, int_fwire_0;
	wire int_fwire_1;

	not (A1__bar, A1);
	and (int_fwire_0, A1__bar, A2);
	not (A2__bar, A2);
	and (int_fwire_1, A1, A2__bar);
	or (Y, int_fwire_1, int_fwire_0);

	// Timing
	specify
		(posedge A1 => (Y:A1)) = 0;
		(negedge A1 => (Y:A1)) = 0;
		(posedge A2 => (Y:A2)) = 0;
		(negedge A2 => (Y:A2)) = 0;
	endspecify
endmodule
`endcelldefine


`ifdef _udp_def_altos_latch_
`else
`define _udp_def_altos_latch_
primitive altos_latch (q, v, clk, d);
	output q;
	reg q;
	input v, clk, d;

	table
		* ? ? : ? : x;
		? 1 0 : ? : 0;
		? 1 1 : ? : 1;
		? x 0 : 0 : -;
		? x 1 : 1 : -;
		? 0 ? : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_err_
`else
`define _udp_def_altos_dff_err_
primitive altos_dff_err (q, clk, d);
	output q;
	reg q;
	input clk, d;

	table
		(0x) ? : ? : 0;
		(1x) ? : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_
`else
`define _udp_def_altos_dff_
primitive altos_dff (q, v, clk, d, xcr);
	output q;
	reg q;
	input v, clk, d, xcr;

	table
		*  ?   ? ? : ? : x;
		? (x1) 0 0 : ? : 0;
		? (x1) 1 0 : ? : 1;
		? (x1) 0 1 : 0 : 0;
		? (x1) 1 1 : 1 : 1;
		? (x1) ? x : ? : -;
		? (bx) 0 ? : 0 : -;
		? (bx) 1 ? : 1 : -;
		? (x0) b ? : ? : -;
		? (x0) ? x : ? : -;
		? (01) 0 ? : ? : 0;
		? (01) 1 ? : ? : 1;
		? (10) ? ? : ? : -;
		?  b   * ? : ? : -;
		?  ?   ? * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_err_
`else
`define _udp_def_altos_dff_r_err_
primitive altos_dff_r_err (q, clk, d, r);
	output q;
	reg q;
	input clk, d, r;

	table
		 ?   0 (0x) : ? : -;
		 ?   0 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 0  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 0  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_r_
`else
`define _udp_def_altos_dff_r_
primitive altos_dff_r (q, v, clk, d, r, xcr);
	output q;
	reg q;
	input v, clk, d, r, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 0;
		?  b   ? (1?) ? : 0 : -;
		?  x   0 (1?) ? : 0 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 0 : -;
		? (x1) 0  ?   0 : ? : 0;
		? (x1) 1  0   0 : ? : 1;
		? (x1) 0  ?   1 : 0 : 0;
		? (x1) 1  0   1 : 1 : 1;
		? (x1) ?  ?   x : ? : -;
		? (bx) 0  ?   ? : 0 : -;
		? (bx) 1  0   ? : 1 : -;
		? (x0) 0  ?   ? : ? : -;
		? (x0) 1  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 0  ?   ? : ? : 0;
		? (01) 1  0   ? : ? : 1;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_err_
`else
`define _udp_def_altos_dff_s_err_
primitive altos_dff_s_err (q, clk, d, s);
	output q;
	reg q;
	input clk, d, s;

	table
		 ?   1 (0x) : ? : -;
		 ?   1 (x0) : ? : -;
		(0x) ?  0   : ? : 0;
		(0x) 1  x   : ? : 0;
		(1x) ?  0   : ? : 1;
		(1x) 1  x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_s_
`else
`define _udp_def_altos_dff_s_
primitive altos_dff_s (q, v, clk, d, s, xcr);
	output q;
	reg q;
	input v, clk, d, s, xcr;

	table
		*  ?   ?  ?   ? : ? : x;
		?  ?   ?  1   ? : ? : 1;
		?  b   ? (1?) ? : 1 : -;
		?  x   1 (1?) ? : 1 : -;
		?  ?   ? (10) ? : ? : -;
		?  ?   ? (x0) ? : ? : -;
		?  ?   ? (0x) ? : 1 : -;
		? (x1) 0  0   0 : ? : 0;
		? (x1) 1  ?   0 : ? : 1;
		? (x1) 1  ?   1 : 1 : 1;
		? (x1) 0  0   1 : 0 : 0;
		? (x1) ?  ?   x : ? : -;
		? (bx) 1  ?   ? : 1 : -;
		? (bx) 0  0   ? : 0 : -;
		? (x0) 1  ?   ? : ? : -;
		? (x0) 0  0   ? : ? : -;
		? (x0) ?  0   x : ? : -;
		? (01) 1  ?   ? : ? : 1;
		? (01) 0  0   ? : ? : 0;
		? (10) ?  ?   ? : ? : -;
		?  b   *  ?   ? : ? : -;
		?  ?   ?  ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_err_
`else
`define _udp_def_altos_dff_sr_err_
primitive altos_dff_sr_err (q, clk, d, s, r);
	output q;
	reg q;
	input clk, d, s, r;

	table
		 ?   1 (0x)  ?   : ? : -;
		 ?   0  ?   (0x) : ? : -;
		 ?   0  ?   (x0) : ? : -;
		(0x) ?  0    0   : ? : 0;
		(0x) 1  x    0   : ? : 0;
		(0x) 0  0    x   : ? : 0;
		(1x) ?  0    0   : ? : 1;
		(1x) 1  x    0   : ? : 1;
		(1x) 0  0    x   : ? : 1;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_0
`else
`define _udp_def_altos_dff_sr_0
primitive altos_dff_sr_0 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   ?   1   ? : ? : 0;
		?  ?   ?   1   0   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_dff_sr_1
`else
`define _udp_def_altos_dff_sr_1
primitive altos_dff_sr_1 (q, v, clk, d, s, r, xcr);
	output q;
	reg q;
	input v, clk, d, s, r, xcr;

	table
	//	v,  clk, d, s, r : q' : q;

		*  ?   ?   ?   ?   ? : ? : x;
		?  ?   ?   0   1   ? : ? : 0;
		?  ?   ?   1   ?   ? : ? : 1;
		?  b   ? (1?)  0   ? : 1 : -;
		?  x   1 (1?)  0   ? : 1 : -;
		?  ?   ? (10)  0   ? : ? : -;
		?  ?   ? (x0)  0   ? : ? : -;
		?  ?   ? (0x)  0   ? : 1 : -;
		?  b   ?  0   (1?) ? : 0 : -;
		?  x   0  0   (1?) ? : 0 : -;
		?  ?   ?  0   (10) ? : ? : -;
		?  ?   ?  0   (x0) ? : ? : -;
		?  ?   ?  0   (0x) ? : 0 : -;
		? (x1) 0  0    ?   0 : ? : 0;
		? (x1) 1  ?    0   0 : ? : 1;
		? (x1) 0  0    ?   1 : 0 : 0;
		? (x1) 1  ?    0   1 : 1 : 1;
		? (x1) ?  ?    0   x : ? : -;
		? (x1) ?  0    ?   x : ? : -;
		? (1x) 0  0    ?   ? : 0 : -;
		? (1x) 1  ?    0   ? : 1 : -;
		? (x0) 0  0    ?   ? : ? : -;
		? (x0) 1  ?    0   ? : ? : -;
		? (x0) ?  0    0   x : ? : -;
		? (0x) 0  0    ?   ? : 0 : -;
		? (0x) 1  ?    0   ? : 1 : -;
		? (01) 0  0    ?   ? : ? : 0;
		? (01) 1  ?    0   ? : ? : 1;
		? (10) ?  0    ?   ? : ? : -;
		? (10) ?  ?    0   ? : ? : -;
		?  b   *  0    ?   ? : ? : -;
		?  b   *  ?    0   ? : ? : -;
		?  ?   ?  ?    ?   * : ? : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_r_
`else
`define _udp_def_altos_latch_r_
primitive altos_latch_r (q, v, clk, d, r);
	output q;
	reg q;
	input v, clk, d, r;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 0;
		? 0 ? 0 : ? : -;
		? 0 ? x : 0 : -;
		? 1 0 0 : ? : 0;
		? 1 0 x : ? : 0;
		? 1 1 0 : ? : 1;
		? x 0 0 : 0 : -;
		? x 0 x : 0 : -;
		? x 1 0 : 1 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_s_
`else
`define _udp_def_altos_latch_s_
primitive altos_latch_s (q, v, clk, d, s);
	output q;
	reg q;
	input v, clk, d, s;

	table
		* ? ? ? : ? : x;
		? ? ? 1 : ? : 1;
		? 0 ? 0 : ? : -;
		? 0 ? x : 1 : -;
		? 1 1 0 : ? : 1;
		? 1 1 x : ? : 1;
		? 1 0 0 : ? : 0;
		? x 1 0 : 1 : -;
		? x 1 x : 1 : -;
		? x 0 0 : 0 : -;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_0
`else
`define _udp_def_altos_latch_sr_0
primitive altos_latch_sr_0 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 0 : ? : 1;
		? ? ? ? 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif

`ifdef _udp_def_altos_latch_sr_1
`else
`define _udp_def_altos_latch_sr_1
primitive altos_latch_sr_1 (q, v, clk, d, s, r);
	output q;
	reg q;
	input v, clk, d, s, r;

	table
		* ? ? ? ? : ? : x;
		? 1 1 ? 0 : ? : 1;
		? 1 0 0 ? : ? : 0;
		? ? ? 1 ? : ? : 1;
		? ? ? 0 1 : ? : 0;
		? 0 * ? ? : ? : -;
		? 0 ? * 0 : 1 : 1;
		? 0 ? 0 * : 0 : 0;
		? * 1 ? 0 : 1 : 1;
		? * 0 0 ? : 0 : 0;
		? ? 1 * 0 : 1 : 1;
		? ? 0 0 * : 0 : 0;
	endtable
endprimitive
`endif
