### <p align="center">Cross-platfoem Game Template</p>

<br/>
<br/>
<br/>
<hr/>
<br/>

Before running the containers, you need to allow the application to access your machine by using the command: `xhost +`.

In the `docker-compose.yml` file, you’ll find several platform options, though most are commented out with only one active. You can choose any platform for development, but it’s recommended to select only one at a time.



### Start
```
docker-compose --env-file public.env up --build --remove-orphans
```