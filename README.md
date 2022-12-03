# Personal configuration management via Saltstack

## Running
In order to update states when running master & minion active.
```bash
sudo salt \* state.apply
```

Another alternative is to run masterless via
```bash
sudo salt-call --local state.apply
```
*Make sure minion configuration's file_client option to 'local'.*
