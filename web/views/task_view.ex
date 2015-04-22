defmodule ToDo.TaskView do
  use ToDo.Web, :view

  def all_lists do
    ToDo.Repo.all(ToDo.List)
  end
end
