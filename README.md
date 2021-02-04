# BigQuery parameterised queries at the command line

Execute a parameterised query in BigQuery with a bash script that accepts
arguments at the command line.

```sh
bash query.sh --input_table=shakespeare --corpus="romeoandjuliet" --min_word_count=250
```

## Requirements

Google's official BigQuery command-line tool,
[`bq`](https://cloud.google.com/bigquery/docs/bq-command-line-tool).  This comes
in a collection of tools called the Google Cloud SDK.

A service account credentials file.  Mine is at
`$HOME/gds/govuk/modular_sql/secrets/my_credentials.json`

## Configuration

```sh
gcloud auth activate-service-account --key-file=/path/to/my_credentials.json
gcloud config set project govuk-bigquery-analytics
```

## References

* [Google's official BigQuery command-line tool, bq](https://cloud.google.com/bigquery/docs/bq-command-line-tool)
* [Running parameterised queries with `bq`](https://cloud.google.com/bigquery/docs/parameterized-queries#bq)
* [Parse command-line arguments in Bash](https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash)
* [Read files into variables in Bash](https://stackoverflow.com/a/10771857/937932)
* [Portable shell string substitution with variables](https://stackoverflow.com/a/22957485/937932)
