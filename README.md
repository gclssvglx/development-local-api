# A `local` API for development purposes

The API takes a postcode and satisfies the following use cases where a postcode is both valid and can be found.


## Example 1 - Simple case

`GET /find-local-council/query.json?postcode=E18QS`

A single council is returned (ie services are all supplied by a single unitary body) - [Response](/response/tower-hamlets.json)


## Example 2 - Two-tier postcode is supplied

`GET /find-local-council/query.json?postcode=DE451QW`

Two councils are returned (ie services are spread across district and county authorities) - [Response](/response/derbyshire-dales.json)


## Example 3 - Ambiguous postcode is supplied

`GET /find-local-council/query.json?postcode=BH228UB`

A list of addresses is returned - the user needs to choose an address to get the result - [Response](/response/addresses.json)


## Example 4 - Address is selected following an ambiguous postcode

`GET /find-local-council/dorset.json`
`GET /find-local-council/bournemouth-christchurch-poole.json`

On choosing an address from the list in Example 3, a follow-up API is required to the appropriate chosen address's `slug`, for example if the `dorset` address is chosen [this response](/response/dorset.json) is returned, if `bournemouth-christchurch-poole` is chosen then [this response](/response/bournemouth-christchurch-poole.json) is returned.


## Invalid postcode

In the event of an invalid postcode, the following `404` response is returned...

```json
{ "message": "Invalid postcode" }
```


## Postcode not found

In the event of a postcode that cannot be found, the following `404` response is returned...

```json
{ "message": "Postcode not found" }
```

## Getting started

The API is built using [Ruby](https://www.ruby-lang.org/en/) and [Sinatra](https://sinatrarb.com/).

Ensure you have [Ruby installed on your system](https://www.ruby-lang.org/en/documentation/installation/), then run `bundle install` at the command line to install the required dependencies.

Then run the API via the following command:

```shell
ruby api.rb
```

The server will start the the API will be available at `localhost` on port `4567`.


## Test URLs

Once running, you can test the API in your browser, using `curl` or via the supplied tests.


### Browser links

- http://localhost:4567/find-local-council/query.json?postcode=E18QS
- http://localhost:4567/find-local-council/query.json?postcode=DE451QW
- http://localhost:4567/find-local-council/query.json?postcode=BH228UB
- http://localhost:4567/find-local-council/dorset.json
- http://localhost:4567/find-local-council/bournemouth-christchurch-poole.json
- http://localhost:4567/find-local-council/query.json?postcode=SW1
- http://localhost:4567/find-local-council/query.json?postcode=SW1A1AA


### `cURL` commands

You'll probably want to use [jq](https://jqlang.org/) to format the JSON output to make it easier to read. If not, just omit the `| jq` part of each command below.


```shell
curl -G -L -d "postcode=E18QS" http://localhost:4567/find-local-council/query.json | jq
curl -G -L -d "postcode=DE451QW" http://localhost:4567/find-local-council/query.json | jq
curl -G -L -d "postcode=BH228UB" http://localhost:4567/find-local-council/query.json | jq
curl -G http://localhost:4567/find-local-council/dorset.json | jq
curl -G http://localhost:4567/find-local-council/bournemouth-christchurch-poole.json | jq
curl -G -L -d "postcode=SW1" http://localhost:4567/find-local-council/query.json | jq
curl -G -L -d "postcode=SW1A1AA" http://localhost:4567/find-local-council/query.json | jq
```


### Tests

```shell
ruby api_test.rb
```
