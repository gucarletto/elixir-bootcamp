defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{
        name: "Gustavo",
        email: "gustavo@gustavo.com",
        password: "123456"
      }

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{
          name: "Gustavo",
          email: "gustavo@gustavo.com",
          password: "123456"
        },
        errors: []
      } = response
    end

    test "when there are invalid params, returns invalid changeset" do
      params = %{
        name: "A",
        email: "gustavogustavo.com",
        password: "123"
      }

      response = User.changeset(params)

      expected_response = %{
        email: {"has invalid format", [validation: :format]},
        name: {"should be at least %{count} character(s)",
        [
          count: 2,
          validation: :length,
          kind: :min,
          type: :string
        ]},
        password: {"should be at least %{count} character(s)",
        [
          count: 6,
          validation: :length,
          kind: :min,
          type: :string
        ]}
      }

      assert errors_on(expected_response)
    end
  end
end
