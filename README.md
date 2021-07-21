## Kong with Moesif

Example Docker application using [Kong Plugin](https://github.com/Moesif/kong-plugin-moesif) to log API calls to [Moesif API analytics](https://www.moesif.com)

To learn more about configuration options, please refer to [Kong Plugin](https://github.com/Moesif/kong-plugin-moesif)

## How to run this example

1. Start the docker container:
```bash
docker-compose -f docker-compose.yml up -d
```

2. Configure the Moesif plugin
```bash
curl -i -X POST --url http://localhost:8001/plugins/ --data "name=moesif" --data "config.application_id=YOUR_APPLICATION_ID";
```

Your Moesif Application Id can be found in the [_Moesif Portal_](https://www.moesif.com/).
After signing up for a Moesif account, your Moesif Application Id will be displayed during the onboarding steps. 

You can always find your Moesif Application Id at any time by logging 
into the [_Moesif Portal_](https://www.moesif.com/), click on the top right menu,
and then clicking _API Keys_.

3. Create a service

```bash
curl -i -X POST \
  --url http://localhost:8001/services/ \
  --data 'name=example-moesif-service' \
  --data 'url=http://httpbin.org/uuid'
```

4. Create a route

```bash
curl -i -X POST \
  --url http://localhost:8001/services/example-moesif-service/routes \
  --data 'hosts[]=test.com'
```

5. By default, The container is listening on port 80. You should now be able to make a request: 

```bash
curl -i -X GET \
  --url http://localhost:80/ \
  --header 'Host: test.com'
```

6. The data should be captured in the corresponding Moesif account.

Congratulations! If everything was done correctly, Moesif should now be tracking all network requests that match the route you specified earlier. If you have any issues with the setup, please reach out to support@moesif.com.

## How to clean db

Remove all the routes and services 

```
kong migrations reset -y
kong migrations bootstrap
```
