REBAR?=rebar3

all: compile

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean
	@rm -rf doc

test:
	@$(REBAR) eunit

dialyzer:
	@$(REBAR) as dialyzer dialyzer

hex-build:
	@$(REBAR) hex build

.PHONY: all compile clean test dialyzer
