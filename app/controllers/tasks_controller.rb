class TasksController < ApplicationController
  def index
    auth
    # @tasks  = Task.order('limit_date').all
    @task   = Task.new
    @status = ['todo', 'doing', 'done']
  end

  def create
    auth
    tp           = task_params
    tp[:user_id] = @auth.id
    @task        = Task.new(tp)
    respond_to do |format|
      if @task.save
        format.html { redirect_to '/tasks', notice: 'タスクを作成しました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to '/tasks', notice: "タスク生成に失敗しました。（理由：#{@task.errors.full_messages[0]}）" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    id      = params[:id]
    @task   = Task.find(id)
    @status = ['todo', 'doing', 'done']
  end

  def update
    # puts params
    id   = params[:id]
    task = Task.find(id)
    t    = task_params

    task.task         = t.has_key?(:task)         ? t[:task]         : task.task
    task.state        = t.has_key?(:state)        ? t[:state]        : task.state
    task.limit_date   = t.has_key?(:limit_date)   ? t[:limit_date]   : task.limit_date
    task.free_comment = t.has_key?(:free_comment) ? t[:free_comment] : task.free_comment

    respond_to do |format|
      if task.save
        format.html { redirect_to '/tasks', notice: 'タスクを更新しました。' }
        format.json { render :show, status: :created, location: task }
      else
        format.html { redirect_to "/tasks/#{id}", notice: "タスク更新に失敗しました。（理由：#{@task.errors.full_messages[0]}）" }
        format.json { render json: task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    task       = Task.find(params[:id])
    task.destroy
    redirect_to '/tasks', notice: 'タスクを削除しました。'
  end

  def done
    task       = Task.find(params[:id])
    task.state = 'done'
    task.save
    redirect_to '/tasks', notice: 'タスクを完了しました。'
  end

  private
  def task_params
    params.require(:task).permit(:task, :state, :free_comment, :limit_date)
  end
end
