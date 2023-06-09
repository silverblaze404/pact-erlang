pact-erlang
=====

An erlang library for contract testing using pact ffi and generating consumer pacts.

This library should be considered alpha quality. It is not yet feature complete and the API is subject to change.

Docs: https://hexdocs.pm/pact_erlang/readme.html

Build
-----

    $ make


Add pact-erlang as a dependency in your application
---------------------------------------------------
```
{deps, [pact_erlang]}.
```

Usage
-----


```erlang
%% Setup
%% Define pact consumer and producer
PactRef = pact:create_new_pact(<<"consumer">>, <<"producer">>).

%% Define the interaction description associated with a pact ref
InteractionRef = pact:create_new_interaction(PactRef, <<"/users api desc">>).

%% Define interaction's request method, path, response content type and body as well as response code
pact:with_request(InteractionRef, <<"GET">>, <<"/users">>).
ResponseJsonString = jsx:encode(#{user_id => 1, user_name => <<"ranjan">>, age => 26}).
pact:with_response_body(InteractionRef, <<"application/json">>, ResponseJsonString).
pact:with_response_status(InteractionRef, 200).

%% Create the mock producer
pact:create_mock_server_for_transport(PactRef, <<"localhost">>, 1234, <<"http">>).


%% test your code which calls the api
Users = user:get_users(),


%% Verify if everything matched successfully
assertEqual({ok, matched}, pact:verify(1234)).


%% Should write Pact File if matched
pact:write_pact_file(PactRef, "/Users/priyaranjan.m/pacts")

%% Cleanup test setup
%% This won't cleanup the pact files, only the pact ref you created in the test setup
pact:cleanup_mock_server(1234)
pact:cleanup_pact(PactRef)
```
Matching request path and request/response headers, and body values
-----

For now the matchers module is not implemented, but we can very much match values.
Refer source - https://github.com/pact-foundation/pact-reference/blob/master/rust/pact_ffi/IntegrationJson.md
