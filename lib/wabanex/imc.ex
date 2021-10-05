defmodule Wabanex.IMC do
  def calculate(filename) do
    filename
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, content}) do
    content
    |> String.split("\n")
  end

  defp handle_file({:error, _reason}) do
    {:error, "Error opening the file"}
  end
end
