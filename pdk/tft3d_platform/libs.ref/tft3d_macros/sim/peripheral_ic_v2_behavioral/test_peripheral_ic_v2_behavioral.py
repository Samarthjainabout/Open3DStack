#!/usr/bin/env python3
"""Smoke tests for the Peripheral_IC v2 behavioral model."""

from peripheral_ic_v2_behavioral import (
    PeripheralICV2Behavioral,
    decode_rows_from_d_pins,
)


def test_program_read_and_search() -> None:
    macro = PeripheralICV2Behavioral()
    macro.program_word(0, 0b1010_1100)
    macro.program_word(1, 0b1010_0100)

    read = macro.read_row(0)
    assert read.details["word"] == 0b1010_1100
    assert read.latency_s > 0
    assert read.energy_j > 0

    search = macro.bcam_search(
        query=0b1010_1100,
        rows=[0, 1],
        max_distance=1,
    )
    assert [hit.distance for hit in search.hits] == [0, 1]
    assert [hit.matched for hit in search.hits] == [True, True]
    assert search.energy_j > read.energy_j


def test_pin_decode_documentation() -> None:
    rows = decode_rows_from_d_pins([1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1])
    assert rows == (5, 10, 19, 28)


if __name__ == "__main__":
    test_program_read_and_search()
    test_pin_decode_documentation()
    print("ok")
