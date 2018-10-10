class TasksController < ApplicationController
  def index
    @task   = Task.order('limit_date').all
    @status = ['todo', 'doing', 'done']
    # puts @status
  end

  def show
    id      = params[:id]
    @task   = Task.find(id)
    @status = ['todo', 'doing', 'done']
  end

  def update
    # puts params
    id   = params[:id]
    task = Task.find(1)

    task.task         = params[:task]
    task.state        = params[:state]
    task.limit_date   = params[:limit_date]
    task.free_comment = params[:free_comment]
    task.save

    redirect_to '/tasks', notice: 'タスクを更新しました。'
  end

  def store
    task = Task.new
    # puts params
    task.task         = params[:task]
    task.state        = params[:state]
    task.limit_date   = params[:limit_date]
    task.free_comment = params[:free_comment]
    task.save

    redirect_to '/tasks', notice: 'タスクを作成しました。'

  end

  def done
    task       = Task.find(params[:id])
    task.state = 'done'
    task.save
    redirect_to '/tasks', notice: 'タスクを完了しました。'
  end

  def destroy
    task       = Task.find(params[:id])
    task.destroy
    redirect_to '/tasks', notice: 'タスクを削除しました。'
  end
end
