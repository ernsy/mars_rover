defmodule MarsRoverTest do
  use ExUnit.Case
  doctest MarsRover

  test "general behaviour tests" do
    assert test_init(["4 8", ["2", "3", "E", "LFRFF"]]) == {{4, 4}, "E", true}
    assert test_init(["4 8", ["0", "2", "N", "FFLFRFF"]]) == {{0, 4}, "W", false}
    assert test_init(["5 4", ["4", "4", "N", "F"]]) == {{4, 4}, "N", false}
    assert test_init(["4 5", ["4", "4", "E", "F"]]) == {{4, 4}, "E", false}
    assert test_init(["1 1", ["1", "1", "S", "FRFLF"]]) == {{0, 0}, "S", false}
    assert test_init(["1 1", ["0", "0", "W", "RRRRRF"]]) == {{0, 1}, "N", true}
    assert test_init(["1 1", ["0", "0", "E", "L"]]) == {{0, 0}, "N", true}
  end

  def test_init(init_args) do
    rover = apply(MarsRover, :init, init_args)
    {rover.coordinates, rover.direction, rover.comm_link}
  end
end
