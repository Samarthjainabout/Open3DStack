"""Peripheral_IC v2 high-level behavioral model."""

from .peripheral_ic_v2_behavioral import (
    COLS,
    ROWS,
    DeviceReadModel,
    EnergyModel,
    OperationReport,
    PeripheralICV2Behavioral,
    SearchHit,
    SearchReport,
    TimingModel,
    bits_to_word,
    decode_rows_from_d_pins,
    encode_d_pins_for_row,
    normalize_mask,
    normalize_word,
    word_to_bits,
)

__all__ = [
    "COLS",
    "ROWS",
    "DeviceReadModel",
    "EnergyModel",
    "OperationReport",
    "PeripheralICV2Behavioral",
    "SearchHit",
    "SearchReport",
    "TimingModel",
    "bits_to_word",
    "decode_rows_from_d_pins",
    "encode_d_pins_for_row",
    "normalize_mask",
    "normalize_word",
    "word_to_bits",
]
