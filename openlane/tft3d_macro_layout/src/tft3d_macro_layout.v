// 3D_TFT layout wrapper built from the available hard-macro blocks.

module tft3d_macro_layout (
    input  wire A,
    input  wire SEL,
    output wire Y
);
    wire inv_y;
    wire pre_y;

    wl_inv u_wl_inv (
        .A(A),
        .Y(inv_y)
    );

    wl_prebuffer u_wl_prebuffer (
        .A(inv_y),
        .Y(pre_y)
    );

    wl_sel u_wl_sel (
        .A(pre_y),
        .SEL(SEL),
        .Y(Y)
    );
endmodule
