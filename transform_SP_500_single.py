import os
import apache_beam as beam
from apache_beam.io import ReadFromText
from apache_beam.io import WriteToText


class TickerSymbol(beam.DoFn):
  def process(self, element):
    record = element
    business_id = record.get('business_id')
    name = record.get('name')

    dict_1 = { 'YUM': ['"Pizza Hut"', '"Taco Bell"', '"KFC"'], 'SBUX': ['"Starbucks"']}
    dict_1['MCD'] = [r""'''"McDonald's"''']
    dict_1['WBA'] = ['"Walgreens"']
    dict_1['UPS'] = ['"The UPS Store"']
    dict_1['CMG'] = ['"Chipotle Mexican Grill"']
    dict_1['JPM'] = ['"Chase Bank"']
    dict_1['WFC'] = ['"Wells Fargo Bank"']
    dict_1['BAC'] = ['"Bank of America"']
    dict_1['BRK'] = ['"Dairy Queen"']
    dict_1['HD'] = ['"The Home Depot"']
    dict_1['CVS'] = ['"CVS Pharmacy"', '"Cvs Pharmacy"']
    dict_1['FDX'] = ['"FedEx Office Print & Ship Center"']
    dict_1['DLTR'] = ['"Dollar Tree"']

    ticker = ''

    for key in dict_1:
      company_list = dict_1[key]
      if name in company_list:
        ticker = key
    if ticker == '':
      return
    else:
      return [(business_id, ticker)]
    

# DoFn performs on each element in the input PCollection.
class MakeRecordFn(beam.DoFn):
  def process(self, element):
     business_id, ticker = element
     record = {'business_id': business_id, 'ticker': ticker}
     return [record]     

PROJECT_ID = os.environ['PROJECT_ID']

# Project ID is needed for BigQuery data source, even for local execution.
options = {
    'project': PROJECT_ID
}
opts = beam.pipeline.PipelineOptions(flags=[], **options)

# Create a Pipeline using a local runner for execution.
with beam.Pipeline('DirectRunner', options=opts) as p:

    query_results = p | 'Read from BigQuery' >> beam.io.Read(beam.io.BigQuerySource(query='SELECT business_id, name FROM Yelp_Dataset.Yelp_Business LIMIT 100'))

    # write PCollection to input file
    query_results | 'Write to log 1' >> WriteToText('input.txt')

    # apply a ParDo to the PCollection
    ticker_symbol = query_results | 'Ticker Symbol' >> beam.ParDo(TickerSymbol())

    # write PCollection to output file
    ticker_symbol | 'Write to log 2' >> WriteToText('output.txt')

    # make BQ records
    
    out_pcoll = ticker_symbol | 'Make BQ Record' >> beam.ParDo(MakeRecordFn())
    
    qualified_table_name = PROJECT_ID + ':Sp500_Dataset.Ticker_List'
    table_schema = 'business_id:STRING,ticker:STRING'
    
    out_pcoll | 'Write to BigQuery' >> beam.io.Write(beam.io.BigQuerySink(qualified_table_name, 
                                                    schema=table_schema,  
                                                    create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                                                    write_disposition=beam.io.BigQueryDisposition.WRITE_TRUNCATE))

    
