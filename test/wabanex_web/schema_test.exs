defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user queries" do
    test "when a valid id is giver, returns the user", %{conn: conn} do
      params = %{email: "gustavo@gustavo.com.,br", name: "Gustavo", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response =
        %{
          "data" => %{
            "getUser" => %{
              "email" => "gustavo@gustavo.com.,br",
              "name" => "Gustavo"
            }
          }
        }

      assert expected_response = response
    end

    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Gustavo", email: "gustavo@gustavo.com", password: "123456"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Gustavo"}}} = response
    end
  end
end
