defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, return data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
          %{
            "Dani" => 20.936639118457304,
            "Gustavo" => 25.53544639152223,
            "Rafael" => 27.968016063681024,
            "Raj" => 25.30864197530864
          }}

      assert expected_response == response
    end

    test "when the file dont exist" do
      params = %{"filename" => "nanana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error opening the file"}

      assert expected_response == response
    end
  end
end
