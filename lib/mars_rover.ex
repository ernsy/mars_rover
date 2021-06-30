defmodule MarsRover do
  @moduledoc """
  Main module for the coding challenge. This module contains the algorithm and is also
  used to create the escript that enables the program to be run from the command line.
  """

  defstruct [:coordinates, :direction, :max_x, :max_y, comm_link: true]

  @rotate_right_directions ["N", "E", "S", "W", "N"]
  @rotate_left_directions Enum.reverse(@rotate_right_directions)

  def start(), do: main([])

  @doc """
  Used as an entry point for the escript.
  """
  def main(_args) do
    grid_size = IO.read(:stdio, :line)

    IO.stream(:stdio, :line)
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.replace(&1, ["(", ",", ")"], ""))
    |> Stream.map(&String.split(&1))
    |> Enum.map(&init(grid_size, &1))
  end

  def init(grid_size, [init_x, init_y, init_direction, commands]) do
    [m, n] = String.split(grid_size) |> Enum.map(&String.to_integer(&1))

    %MarsRover{
      coordinates: {String.to_integer(init_x), String.to_integer(init_y)},
      direction: init_direction,
      max_x: m,
      max_y: n
    }
    |> handle_commands(commands)
  end

  def handle_commands(
        rover = %MarsRover{direction: direction, coordinates: {prev_x, prev_y}},
        <<>>
      ) do
    if rover.comm_link do
      IO.puts("(#{prev_x}, #{prev_y}, #{direction})")
    else
      IO.puts("(#{prev_x}, #{prev_y}, #{direction}) LOST")
    end

    rover
  end

  def handle_commands(rover = %MarsRover{}, <<command, rem_commands::binary>>) do
    rover =
      cond do
        command == ?F -> move_forward(rover)
        command == ?R -> rotate(rover, @rotate_right_directions)
        command == ?L -> rotate(rover, @rotate_left_directions)
      end

    if rover.comm_link,
      do: handle_commands(rover, rem_commands),
      else: handle_commands(rover, <<>>)
  end

  defp move_forward(rover = %MarsRover{coordinates: {prev_x, prev_y}}) do
    {x, y} =
      case rover.direction do
        "N" -> {prev_x, prev_y + 1}
        "S" -> {prev_x, prev_y - 1}
        "W" -> {prev_x - 1, prev_y}
        "E" -> {prev_x + 1, prev_y}
      end

    if x >= 0 and y >= 0 and x <= rover.max_x and y <= rover.max_y do
      %{rover | coordinates: {x, y}}
    else
      %{rover | coordinates: {prev_x, prev_y}, comm_link: false}
    end
  end

  defp rotate(rover, []), do: rover

  defp rotate(rover = %MarsRover{direction: d}, [d, next_direction | _]),
    do: %{rover | direction: next_direction}

  defp rotate(rover, [_ | rem_directions]), do: rotate(rover, rem_directions)
end
