defmodule ToDo.ListController do
  use ToDo.Web, :controller

  alias ToDo.List

  plug :scrub_params, "list" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    lists = Repo.all(List) |> Repo.preload :tasks
    render conn, "index.html", lists: lists
  end

  def new(conn, _params) do
    changeset = List.changeset(%List{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"list" => list_params}) do
    changeset = List.changeset(%List{}, list_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "List created successfully.")
      |> redirect(to: list_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    list  = Repo.get(List, id) |> Repo.preload :tasks
    render conn, "show.html", list: list
  end

  def edit(conn, %{"id" => id}) do
    list = Repo.get(List, id)
    changeset = List.changeset(list)
    render conn, "edit.html", list: list, changeset: changeset
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Repo.get(List, id)
    changeset = List.changeset(list, list_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "List updated successfully.")
      |> redirect(to: list_path(conn, :index))
    else
      render conn, "edit.html", list: list, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Repo.get(List, id)
    Repo.delete(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end
end
