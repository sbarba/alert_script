## Synopsis

This is just an alert script that emails me when a new set's been added to the SWLCG plugin for OCTGN.

## Configuration

Depends on a file called constants.txt in the same directory as the script.

* First line is the path to the SWLCG plugin repo.
* Second line is the address to email if a new set is found.

Example content:
```
/path/to/repo/Star-Wars-LCG-OCTGN/o8g/Sets
user@email.com
```

Run the script with a cron job.
