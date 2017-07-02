defmodule Formex.Validator.Vex.Test.UserType do
  use Formex.Type

  def build_form(form) do
    form
    |> add(:first_name, validation: [
      presence: :true
    ])
    |> add(:last_name, validation: [
      presence: [message: "give me your name!"]
    ])
    # |> add(:age, validation: [
    #   presence: :true
    # ])
    |> add(:user_addresses, Formex.Validator.Vex.Test.UserAddressType,
      struct_module: Formex.Validator.Vex.Test.UserAddress,
      validation: [
        length: [min: 2]
      ])
  end
end

defmodule Formex.Validator.Vex.Test.UserAddressType do
  use Formex.Type

  def build_form(form) do
    form
    |> add(:street, validation: [presence: :true])
  end
end

defmodule Formex.Validator.Vex.Test do
  use ExUnit.Case
  import Formex.Builder
  use Formex.Controller
  alias Formex.Validator.Vex.Test.UserType
  alias Formex.Validator.Vex.Test.User

  test "basic" do
    params      = %{"first_name" => "", "last_name" => "", "age" => "10", "user_addresses" => %{
      "0" => %{"street" => "a"}
    }}
    form        = create_form(UserType, %User{}, params)
    {:error, form} = handle_form(form)

    assert form.errors[:first_name]     == ["must be present"]
    assert form.errors[:last_name]      == ["give me your name!"]
    assert form.errors[:user_addresses] == ["must have a length of at least 2"]

    params      = %{"first_name" => "a", "last_name" => "a", "age" => "20", "user_addresses" => %{
      "0" => %{"street" => "a"}, "1" => %{"street" => "b"}
    }}
    form        = create_form(UserType, %User{}, params)
    {:ok, _} = handle_form(form)
  end
end
