defmodule Luhn.OG do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number_without_spaces = String.replace(number, " ", "")

    if Integer.parse(number_without_spaces) == :error do
      false

    else
      number_without_spaces
      |> String.to_charlist()
      |> valid_charlist?()
    end
  end

  defp valid_charlist?([_single_digit | []]), do: false

  defp valid_charlist?(charlist) do
    [last_digit | other_digits] =
      charlist
      |> Enum.reverse()
      |> Enum.map(&(&1 - 48))

    other_digits
    |> Enum.map_every(2, &luhn_double/1)
    |> Enum.sum()
    |> Kernel.+(last_digit)
    |> rem(10) == 0
  end

  defp luhn_double(digit) when digit * 2 > 9 do
    digit * 2 - 9
  end

  defp luhn_double(digit), do: digit * 2
end
