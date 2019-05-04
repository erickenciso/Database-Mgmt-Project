import datetime
from airflow import models
from airflow.operators.bash_operator import BashOperator
from airflow.operators.dummy_operator import DummyOperator

default_dag_args = {
    # https://airflow.apache.org/faq.html#what-s-the-deal-with-start-date
    'start_date': datetime.datetime(2019, 4, 1)
}

raw_dataset = 'Yelp_Dataset' # dataset with raw tables
new_dataset = 'workflow' # empty dataset for destination tables
sql_cmd_start = 'bq query --use_legacy_sql=false '


sql_business = 'create table ' + new_dataset + '.Business_Temp as ' \
           'select * ' \
           'from ' + raw_dataset + '.Yelp_Business ' \


sql_user = 'create table ' + new_dataset + '.User_Temp as ' \
            'select * ' \
            'from ' + raw_dataset + '.Yelp_User ' \
            
            
sql_review = 'create table ' + new_dataset + '.Review_Temp as ' \
            'select * ' \
            'from ' + raw_dataset + '.Yelp_Reviews ' \
            

###### Beam variables ###### 
AIRFLOW_DAGS_DIR='/home/ohyoon425/.local/bin/dags'
LOCAL_MODE=1 # run beam jobs locally
DIST_MODE=2 # run beam jobs on Dataflow

mode=LOCAL_MODE

if mode == LOCAL_MODE:
    user_script = 'workflow_transform_single1.py' 
    user1_script = 'workflow_transform_single2.py'
    
if mode == DIST_MODE:
    user_script = 'workflow_transform_cluster1.py'
    user1_script = 'workflow_transform_cluster2.py'
    
###### DAG section ###### 
with models.DAG('workflow',
        schedule_interval=datetime.timedelta(days=1),
        default_args=default_dag_args) as dag:
        
    ###### SQL tasks ######
    delete_dataset = BashOperator(
            task_id='delete_dataset',
            bash_command='bq rm -r -f workflow')
                
    create_dataset = BashOperator(
            task_id='create_dataset',
            bash_command='bq mk workflow')
                    
    create_business_table = BashOperator(
            task_id='create_business_table',
            bash_command=sql_cmd_start + '"' + sql_business + '"')
            
    create_user_table = BashOperator(
            task_id='create_user_table',
            bash_command=sql_cmd_start + '"' + sql_user + '"')
    
    create_review_table = BashOperator(
            task_id='create_review_table',
            bash_command=sql_cmd_start + '"' + sql_review + '"')

	###### Beam tasks ######     
    user_beam = BashOperator(
            task_id='user_beam',
            bash_command='python ' + AIRFLOW_DAGS_DIR + user_script)
            
    user1_beam = BashOperator(
            task_id='user1_beam',
            bash_command='python ' + AIRFLOW_DAGS_DIR + user1_script)
            

    transition = DummyOperator(task_id='transition')
    
    delete_dataset >> create_dataset >> [create_business_table, create_user_table, create_review_table] >> transition
    transition >> [user_beam, user1_beam]


