defmodule ToDo.TaskController do
  use ToDo.Web, :controller

  alias ToDo.Task

  plug :scrub_params, "task" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    tasks = Repo.all(Task)
    render conn, "index.html", tasks: tasks
  end

  def new(conn, params) do
    list_id   = Dict.get(params, "list_id") |> String.to_integer
    changeset = Task.changeset(%Task{})
    render conn, "new.html", %{changeset: changeset, list_id: list_id }
  end

  def create(conn, %{"task" => task_params}) do
    IO.inspect(task_params)
    changeset = Task.changeset(%Task{}, task_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Task created successfully.")
      |> redirect(to: task_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    task = Repo.get(Task, id) |> Repo.preload :list
    render conn, "show.html", task: task
  end

  def edit(conn, %{"id" => id}) do
    task = Repo.get(Task, id)
    changeset = Task.changeset(task)
    render conn, "edit.html", task: task, changeset: changeset
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Repo.get(Task, id)
    changeset = Task.changeset(task, task_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Task updated successfully.")
      |> redirect(to: task_path(conn, :index))
    else
      render conn, "edit.html", task: task, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Repo.get(Task, id)
    Repo.delete(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
