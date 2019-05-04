# tasks that ran
[1] delete_dataset
[2] create_dataset
[3] create_business_table
[4] create_user_table
[5] create_review_table
[6] transition (added this because it is showing 'succeeded:6')

# tasks that did not run
[1] user_beam (split friends)
[2] user1_beam (count friends)



[2019-05-04 04:33:27,436] {jobs.py:2124} INFO - [backfill progress] | finished run 1 of 1 | tasks waiting: 0 | succ
eeded: 6 | running: 0 | failed: 2 | skipped: 0 | deadlocked: 0 | not ready: 0
Traceback (most recent call last):
  File "/home/ohyoon425/.local/bin/airflow", line 32, in <module>
    args.func(args)
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/utils/cli.py", line 74, in wrapper
    return f(*args, **kwargs)
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/bin/cli.py", line 217, in backfill
    run_backwards=args.run_backwards
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/models/__init__.py", line 4030, in run
    job.run()
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/jobs.py", line 209, in run
    self._execute()
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/utils/db.py", line 73, in wrapper
    return func(*args, **kwargs)
  File "/home/ohyoon425/.local/lib/python2.7/site-packages/airflow/jobs.py", line 2482, in _execute
    raise AirflowException(err)
airflow.exceptions.AirflowException: ---------------------------------------------------
Some task instances failed:
set([(u'workflow', u'user1_beam', datetime.datetime(2019, 5, 3, 0, 0, tzinfo=<Timezone [UTC]>), 1), (u'workflow', u
'user_beam', datetime.datetime(2019, 5, 3, 0, 0, tzinfo=<Timezone [UTC]>), 1)])
