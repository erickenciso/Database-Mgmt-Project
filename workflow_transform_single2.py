import os
import apache_beam as beam
from apache_beam.io import ReadFromText
from apache_beam.io import WriteToText

# DoFn to perform on each element in the input PCollection.
#Will return user id and number of friends for user
class CountFriends(beam.DoFn):
  def process(self, element):
    record = element
    user_id = record.get('user_id')
    str_friends = record.get('friends')
    l_friends = str_friends.split(', ')
    

    if str_friends == 'None':
        return [(user_id, 0)]
    else:
        friends = len(l_friends)
	return [(user_id, friends)]

# DoFn performs on each element in the input PCollection.
#will make record to be used by Bigquery
class MakeRecordFn(beam.DoFn):
  def process(self, element):
     name, friend_count = element
     record = {'user_id': name, 'number_of_friends': friend_count}
     return [record] 
    

PROJECT_ID = os.environ['PROJECT_ID']

# Project ID is needed for BigQuery data source, even for local execution.
options = {
    'project': PROJECT_ID
}
opts = beam.pipeline.PipelineOptions(flags=[], **options)

# Create a Pipeline using a local runner for execution.
with beam.Pipeline('DirectRunner', options=opts) as p:

    query_results = p | 'Read from BigQuery' >> beam.io.Read(beam.io.BigQuerySource(query='SELECT user_id, friends FROM workflow.User_Temp LIMIT 100'))

    # write PCollection to input file
    query_results | 'Write to log 1' >> WriteToText('input.txt')

    # apply a ParDo to the PCollection
    friends_split = query_results | 'Extract Friends' >> beam.ParDo(CountFriends())

    # write PCollection to output file
    friends_split | 'Write to log 2' >> WriteToText('output.txt')

    # make BQ records
    out_pcoll = friends_split | 'Make BQ Record' >> beam.ParDo(MakeRecordFn())
    
    qualified_table_name = PROJECT_ID + ':workflow.Friend_Count'
    table_schema = 'user_id:STRING,number_of_friends:INTEGER'
    
    out_pcoll | 'Write to BigQuery' >> beam.io.Write(beam.io.BigQuerySink(qualified_table_name, 
                                                    schema=table_schema,  
                                                    create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                                                    write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE))

    