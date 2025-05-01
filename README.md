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

In the event of an invalid postcode, the following `400` response is returned...

```json
{ "message": "Invalid postcode" }
```


## Postcode not found

In the event of a postcode that cannot be found, the following `404` response is returned...

```json
{ "message": "Postcode not found" }
```


## Rate limiting

In the event of a postcode that is `SW1A2AB`, the following `429` response is returned...

```json
{ "message": "Too many requests" }
```
