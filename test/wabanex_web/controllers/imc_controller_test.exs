defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, return imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}
      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

        expected_response = %{
          "result" => %{
            "Dani" => 20.936639118457304,
            "Gustavo" => 25.53544639152223,
            "Rafael" => 27.968016063681024,
            "Raj" => 25.30864197530864
          }
        }

        assert expected_response == response
    end

    test "when there are invalid params, return error", %{conn: conn} do
      params = %{"filename" => "studsadaents.csv"}
      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

        expected_response = %{
          "result" => "Error opening the file"
        }

        assert expected_response == response
    end
  end
end
