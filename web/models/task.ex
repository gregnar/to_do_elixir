defmodule ToDo.Task do
  use ToDo.Web, :model

  schema "tasks" do
    field :name, :string
    field :description, :string
    belongs_to :list, ToDo.List
    timestamps
  end

  @required_fields ~w(name description list_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
