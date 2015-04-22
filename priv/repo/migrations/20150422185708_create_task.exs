defmodule ToDo.Repo.Migrations.CreateTask do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :description, :string
      add :list_id, :integer

      timestamps
    end
  end
end
