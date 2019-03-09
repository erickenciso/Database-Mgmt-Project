import os, datetime
import apache_beam as beam
from apache_beam.io import ReadFromText
from apache_beam.io import WriteToText

# DoFn to perform on each element in the input PCollection. Which will split the
#friends column and create an element for every friend a user has

class SplitFriends(beam.DoFn):
  def process(self, element):
    record = element
    user_id = record.get('user_id')
    str_friends = record.get('friends')
    l_friends = str_friends.split(', ')
    

    if str_friends == 'None':
        return
    else:
        friends_list = []
        for i in l_friends:
	    friends_list.append((user_id, i))
	return friends_list

# DoFn performs on each element in the input PCollection.
class MakeRecordFn(beam.DoFn):
  def process(self, element):
     name, friend = element
     record = {'name': name, 'friend': friend}
     return [record]     

PROJECT_ID = os.environ['PROJECT_ID']
BUCKET = os.environ['BUCKET']
DIR_PATH = BUCKET + '/output/' + datetime.datetime.now().strftime('%Y_%m_%d_%H_%M_%S') + '/'

# Project ID is needed for BigQuery data source, even for local execution.
# run pipeline on Dataflow 
options = {
    'runner': 'DataflowRunner',
    'job_name': 'transform-student-table',
    'project': PROJECT_ID,
    'temp_location': BUCKET + '/temp',
    'staging_location': BUCKET + '/staging',
    'machine_type': 'n1-standard-1', # machine types listed here: https://cloud.google.com/compute/docs/machine-types
    'num_workers': 1
}
opts = beam.pipeline.PipelineOptions(flags=[], **options)


with beam.Pipeline('DataflowRunner', options=opts) as p:

    query_results = p | 'Read from BigQuery' >> beam.io.Read(beam.io.BigQuerySource(query='SELECT user_id, friends FROM Yelp_Dataset.Yelp_User'))

    # write PCollection to input file
    query_results | 'Write to log 1' >> WriteToText(DIR_PATH + 'input.txt')

    # apply a ParDo to the PCollection
    friends_split = query_results | 'Extract Friends' >> beam.ParDo(SplitFriends())

    # write PCollection to output file
    friends_split | 'Write to log 2' >> WriteToText(DIR_PATH + 'output.txt')

    # make BQ records
    out_pcoll = friends_split | 'Make BQ Record' >> beam.ParDo(MakeRecordFn())
    
    qualified_table_name = PROJECT_ID + ':Yelp_Dataset.Friend_List1'
    table_schema = 'name:STRING,friend:STRING'
    
    out_pcoll | 'Write to BigQuery' >> beam.io.Write(beam.io.BigQuerySink(qualified_table_name, 
                                                    schema=table_schema,  
                                                    create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                                                    write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE))

    