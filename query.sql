SELECT
  word, word_count
FROM
  `bigquery-public-data.samples.@input_table`
WHERE
  corpus = @corpus
AND
  word_count >= @min_word_count
ORDER BY
  word_count DESC
