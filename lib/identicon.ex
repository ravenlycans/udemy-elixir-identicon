defmodule Identicon do



  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  defp build_grid(%Identicon.Image{hex: hex} = image) do
      grid = Enum.chunk_every(hex, 3, 3, :discard)
      |> Enum.map(&mirror_row/1)

      %Identicon.Image{image | grid: grid}
  end

  defp mirror_row([first, second | _rest] = row) do
    row ++ [second, first]
  end

  defp pick_color(%Identicon.Image{hex: [red, green, blue | _rest]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  defp hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
