# MotimateAssignment

##Description

Write a script that will parse a file with following file structure (2 spaces row delimiter):

``` 
ID  Created at  Status  Size  Database
a810  2019-07-10 00:08:02 +0000  Completed 2019-07-10 00:18:53 +0000  482.43MB  DATABASE
a179  2019-07-09 00:06:19 +0000  Completed 2019-07-09 00:23:42 +0000  480.99MB  DATABASE
a278  2019-07-08 00:06:19 +0000  Completed 2019-07-08 00:16:04 +0000  479.59MB  DATABASE
a827  2019-07-07 00:08:02 +0000  Completed 2019-07-07 00:18:43 +0000  481.75MB  DATABASE
```
You have to extract IDs of backups that were created more than 30 days ago. 
Next you have to send the IDs (one by one) to the API endpoint `PUT https://example.com/remove-backup?backup_id=#{ID}`.
Correct API response status is `200`, if it returns something else you also have to store the response body in the file with following format:

``` 
ID    Created at    Status Code ErrorDescription
a680  2019-07-10 00:08:02 +0000  Removed 200
a181  2019-07-10 00:08:02 +0000  Error  500 "{error: 'invalid ID' }"
``` 

Also write a script that will parse the events log text file and return the number of successful and failed backups deletions based on date range arguments provided.

Please include specs and provide an object oriented structure for the code.
Please send the result as a private GitHub repo and invite the user "pawurb" as a collabolator to it

## Installation
With the console on project's folder, build the gem from the gemspec:

`gem build motimate_assignment.gemspec`

After building the gem, install it locally to test it out:

`gem install ./motimate_assignment-0.1.0.gem`