require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # t.text     :state
  # t.text     :task
  # t.date     :limit_date
  # t.text     :free_comment
  def setup
    @task = Task.new(state: 'done', task: 'task1', limit_date: '2018-10-10', free_comment: 'test', user_id: 1)
  end
  test "検証成功" do
    assert @task.valid?
  end
  test "検証失敗_taskが空白" do
    @task.task = ' '
    assert_not @task.valid?
  end
  test "検証失敗_stateが空白" do
    @task.state = ' '
    assert_not @task.valid?
  end
  test "検証失敗_limit_dateが空白" do
    @task.limit_date = " "
    assert_not @task.valid?
  end
  test "検証失敗_limit_dateが日付ではない" do
    @task.limit_date = "this is not date."
    assert_not @task.valid?
  end
  test "検証失敗_user_idが空白" do
    @task.user_id = ''
    assert_not @task.valid?
  end
  test "検証失敗_user_idが負の値" do
    @task.user_id = -1
    assert_not @task.valid?
  end
  test "検証失敗_user_idが小数点" do
    @task.user_id = 1.32
    assert_not @task.valid?
  end
  
end
