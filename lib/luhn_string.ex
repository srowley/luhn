defmodule Luhn.String do
  @valid_digits ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

  defguard is_odd?(integer) when rem(integer, 2) != 0
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number
    |> String.replace(" ", "")
    |> String.reverse()
    |> valid?(0, 0)
  end

  def valid?(<<_number::binary-size(1)>>, 0, 0), do: false

  def valid?(<<digit::binary-size(1), _trailing::binary>>, _index, _sum)
      when digit not in @valid_digits do
    false
  end

  def valid?("", _index, sum), do: rem(sum, 10) == 0

  def valid?(<<digit::binary-size(1), trailing::binary>>, 0, 0) do
    valid?(trailing, 1, String.to_integer(digit))
  end

  def valid?(<<digit::binary-size(1), trailing::binary>>, index, sum) when is_odd?(index) do
    new_sum = luhn_double(digit) + sum
    valid?(trailing, index + 1, new_sum)
  end

  def valid?(<<digit::binary-size(1), trailing::binary>>, index, sum) do
    new_sum = String.to_integer(digit) + sum
    valid?(trailing, index + 1, new_sum)
  end

  defp luhn_double(digit) when is_binary(digit) do
    digit
    |> String.to_integer()
    |> luhn_double
  end

  defp luhn_double(digit) when digit * 2 > 9 do
    digit * 2 - 9
  end

  defp luhn_double(digit), do: digit * 2
end
