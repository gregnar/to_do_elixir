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
    all_lists = Repo.all(List)
    list_id   = Dict.get(params, "list_id")
    changeset = Task.changeset(%Task{list_id: list_id})
    render conn, "new.html", %{changeset: changeset, all_lists: all_lists}
  end

  def create(conn, %{"task" => task_params}) do
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
