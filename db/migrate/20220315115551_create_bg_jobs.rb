class CreateBgJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :bg_jobs do |t|
      t.integer :job_runnable_id
      t.string :job_runnable_type
      t.integer :worker_job_id
      t.string :job_type

      t.timestamps null: false
    end
    add_index :bg_jobs, :job_runnable_id
    add_index :bg_jobs, :job_runnable_type
    add_index :bg_jobs, :worker_job_id
    add_index :bg_jobs, :job_type
  end
end
