#!/bin/sh

# Troubleshooting
#
# If the following command doesn't create the expected output, then the problem
# isn't this script.
#
# bq query \
# --use_legacy_sql=false \
# --parameter=corpus::romeoandjuliet \
# --parameter=min_word_count:INT64:250 \
# 'SELECT
#   word, word_count
# FROM
#   `bigquery-public-data.samples.shakespeare`
# WHERE
#   corpus = @corpus
# AND
#   word_count >= @min_word_count
# ORDER BY
#   word_count DESC'
#
# Expected output:
# Waiting on bqjob_r451eb1dca5fa232_000001776db54fd4_1 ... (0s) Current status: DONE
# +------+------------+
# | word | word_count |
# +------+------------+
# | the  |        614 |
# | I    |        577 |
# | and  |        490 |
# | to   |        486 |
# | a    |        407 |
# | of   |        367 |
# | my   |        314 |
# | is   |        307 |
# | in   |        291 |
# | you  |        271 |
# | that |        270 |
# | me   |        263 |
# +------+------------+

# Command-line argument parsing based on
# https://stackoverflow.com/a/14203146/937932
for i in "$@"
do
case $i in
    --input_table=*)
    input_table="${i#*=}"
    shift # past argument=value
    ;;
    --corpus=*)
    corpus="${i#*=}"
    shift # past argument=value
    ;;
    --min_word_count=*)
    min_word_count="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

# Read the query into a variable
# https://stackoverflow.com/a/10771857/937932
sql=`cat query.sql`

# Substitute command-line arguments for

# We have to do substitutions in two ways.
#
# 1. The Google BigQuery way, which is safer but only works for certain things.
# 2. Bash substitutions, for everything else, and is no less safe when users
#    already have permissions to execute arbitrary SQL willy nilly.
#
# See: https://cloud.google.com/bigquery/docs/parameterized-queries
#
# > Query parameters can be used as substitutes for arbitrary expressions.
# > Parameters cannot be used as substitutes for identifiers, column names,
# > table names, or other parts of the query.
#
# We use the same syntax for both, i.e. @param_name is a placeholder to be
# substituted.

# For portable shell string substituion with variables, see
# https://stackoverflow.com/a/22957485/937932
sql=$(echo "$sql" | sed "s/@input_table/$input_table/g")

# Call the query
bq query \
--use_legacy_sql=false \
--parameter=corpus::${corpus} \
--parameter=min_word_count:INT64:${min_word_count} \
${sql}
