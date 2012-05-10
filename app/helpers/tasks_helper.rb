module TasksHelper
  def nested_tasks(tasks)
    rendering = ""
    tasks.each do |task|
      #rendertask = render(task)
      #rendersubtasks = task.subtasks.count > 0 ? ('<div class="nested_tasks">' + nested_tasks(task.subtasks) + '</div>') : ""
      #rendertask + rendersubtasks
      rendering += render(task)
      if (task.subtasks.count > 0)
        rendering += '<div class="nested_tasks">' + nested_tasks(task.subtasks) + '</div>'
      end
    end
    rendering.html_safe
    # end.join.html_safe
  end
end

