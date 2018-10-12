require 'test_helper'

class TasksCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "タスクを生成する" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to '/tasks'
    follow_redirect!
    assert is_login?

    assert_difference 'Task.count', 1 do
      post tasks_path, params: {
        task: {
          task:         'task1',
          state:        'done',
          free_comment: 'free comment',
          limit_date:   '2018-12-01'
        }
      }
    end

    # create
    assert_redirected_to '/tasks'
    follow_redirect!
    assert_template 'tasks/index'
    @user.tasks.each do |t|
      assert_select 'a[href=?]', "/tasks/#{t.id}"
    end

    # update
    task  = @user.tasks[0]
    id    = task.id
    get "/tasks/#{id}"
    assert_template 'tasks/show'
    put "/tasks/#{id}", params: {
      task: {
        task:         'task1-1',
        state:        'doing',
        free_comment: '',
        limit_date:   '2018-10-01'
      }
    }
    assert_redirected_to '/tasks'
    follow_redirect!

    # delete
    delete "/tasks/#{id}"
    assert_response :redirect
    assert_select 'a[href=?]', "/tasks/#{id}", count: 0

  end
  # test "the truth" do
  #   assert true
  # end
  # test "the truth" do
  #   assert true
  # end
  # test "the truth" do
  #   assert true
  # end
  # test "the truth" do
  #   assert true
  # end
end
