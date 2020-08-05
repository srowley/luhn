number = Enum.random(1..10000000) |> to_string()

Benchee.run(%{
  "string_luhn" => fn -> Luhn.String.valid?(number) end,
  "original_luhn" => fn -> Luhn.OG.valid?(number) end
  # "index_luhn" => fn -> Luhn.Index.valid?(number) end
})
