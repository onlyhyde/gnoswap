# Test Mnemonic
# source bonus chronic canvas draft south burst lottery vacant surface solve popular case indicate oppose farm nothing bullet exhibit title speed wink action roast

# Test Accounts
# gnokey add -recover=true -index 10 gsa
# gnokey add -recover=true -index 11 lp01
ADDR_GSA := g12l9splsyngcgefrwa52x5a7scc29e9v086m6p4
ADDR_LP01 := g1jqpr8r5akez83kp7ers0sfjyv2kgx45qa9qygd

ADDR_POOL := g15z32w7txv6lw259xzhzzmwtwmcjjc0m6dqzh6f
ADDR_POS := g10wwa53xgu4397kvzz7akxar9370zjdpwux5th9
ADDR_STAKER := g1puv9dz470prjshjm9qyg25dyfvrgph2kvjph68
ADDR_ROUTER := g1pjtpgjpsn4hjfv2n4mpz8cczdn32jkpsqwxuav
ADDR_GOV := g1kmat25auuqf0h5qvd4q7s707r8let5sky4tr76

TX_EXPIRE := 9999999999

MAKEFILE := $(shell realpath $(firstword $(MAKEFILE_LIST)))
GNOLAND_RPC_URL ?= localhost:26657
CHAINID ?= dev
ROOT_DIR:=$(shell dirname $(MAKEFILE))/..

.PHONY: help
help:
	@echo "Available make commands:"
	@cat $(MAKEFILE) | grep '^[a-z][^:]*:' | cut -d: -f1 | sort | sed 's/^/  /'

.PHONY: all
all: wait deploy faucet approve pool-setup position-setup done

.PHONY: deploy
deploy: deploy-grc20s deploy-gnft deploy-gov deploy-pool deploy-position deploy-staker deploy-router deploy-grc20_wrapper 

.PHONY: approve
approve: approve-test1

.PHONY: pool-setup
pool-setup: pool-init pool-create

.PHONY: position-setup
position-setup: position-mint

wait:
	$(shell sleep 10)

# Deploy Tokens
deploy-grc20s:
	$(info ************ [GRC20] deploy tokens ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/wugnot -pkgpath gno.land/r/demo/wugnot -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/bar -pkgpath gno.land/r/demo/bar -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/baz -pkgpath gno.land/r/demo/baz -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/foo -pkgpath gno.land/r/demo/foo -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/fred -pkgpath gno.land/r/demo/fred -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/gns -pkgpath gno.land/r/demo/gns -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/obl -pkgpath gno.land/r/demo/obl -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/qux -pkgpath gno.land/r/demo/qux -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/st1 -pkgpath gno.land/r/demo/st1 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/st2 -pkgpath gno.land/r/demo/st2 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/st3 -pkgpath gno.land/r/demo/st3 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/st4 -pkgpath gno.land/r/demo/st4 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/st5 -pkgpath gno.land/r/demo/st5 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo
	
deploy-gnft:
	$(info ************ [GNFT] deploy lp token ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/gnft -pkgpath gno.land/r/demo/gnft -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

# Deploy Contracts
deploy-gov:
	$(info ************ [GOV] deploy governance ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/gov -pkgpath gno.land/r/demo/gov -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

deploy-pool:
	$(info ************ [POOL] deploy pool ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/pool -pkgpath gno.land/r/demo/pool -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

deploy-position:
	$(info ************ [POSITION] deploy position ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/position -pkgpath gno.land/r/demo/position -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

deploy-staker:
	$(info ************ [STAKER] deploy staker ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/staker -pkgpath gno.land/r/demo/staker -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

deploy-router:
	$(info ************ [ROUTER] deploy router ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/router -pkgpath gno.land/r/demo/router -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

deploy-grc20_wrapper:
	$(info ************ [GRC20 Wrapper] deploy grc20_wrapper ************)
	@echo "" | gnokey maketx addpkg -pkgdir $(ROOT_DIR)/_setup/grc20_wrapper_init -pkgpath gno.land/r/demo/grc20_wrapper -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo


# Approve Tokens
faucet:
	$(info ************ [FAUCET]  grc20 tokens for minting ************)
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/bar -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/baz -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/foo -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/fred -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/gns -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/obl -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/qux -func FaucetL -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

approve-test1:
	$(info ************ [APPROVE] grc20 tokens from test1 to pool ************)
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/wugnot -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/bar -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/baz -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/foo -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/fred -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/gns -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/obl -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/qux -func Approve -args $(ADDR_POOL) -args 500000000000000 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo


# Pool
pool-init:
	$(info ************ [POOL] init pool ************)
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func InitManual -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo

pool-create:
	$(info ************ [POOL] create pools ************)
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func CreatePool -args "gno.land/r/demo/wugnot" -args "gno.land/r/demo/bar" -args 100 -args 112046559425783515914356180039 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func CreatePool -args "gno.land/r/demo/bar" -args "gno.land/r/demo/baz" -args 100 -args 112046559425783515914356180039 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func CreatePool -args "gno.land/r/demo/baz" -args "gno.land/r/demo/foo" -args 100 -args 177166786517138269218369076073 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func CreatePool -args "gno.land/r/demo/gns" -args "gno.land/r/demo/wugnot" -args 100 -args 79228162514264337593543950337 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/pool -func CreatePool -args "gno.land/r/demo/gns" -args "gno.land/r/demo/qux" -args 100 -args 250553947533412109193337304115 -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo


# Position
position-mint:
	$(info ************ [POSITION] MINT ************)
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/wugnot -func Deposit -send "10000000000ugnot" -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null

	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/position -func Mint -args "gno.land/r/demo/wugnot" -args "gno.land/r/demo/bar" -args 100 -args 5932 -args 7932 -args 1000000000 -args 10000000000 -args 0 -args 0 -args $(TX_EXPIRE) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/position -func Mint -args "gno.land/r/demo/bar" -args "gno.land/r/demo/baz" -args 100 -args 5932 -args 7932 -args 1000000000 -args 10000000000 -args 0 -args 0 -args $(TX_EXPIRE) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/position -func Mint -args "gno.land/r/demo/baz" -args "gno.land/r/demo/foo" -args 100 -args 15096 -args 17096 -args 1000000000 -args 10000000000 -args 0 -args 0 -args $(TX_EXPIRE) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/position -func Mint -args "gno.land/r/demo/gns" -args "gno.land/r/demo/wugnot" -args 100 -args -1000 -args 1000 -args 1000000000 -args 1000000000 -args 0 -args 0 -args $(TX_EXPIRE) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo "" | gnokey maketx call -pkgpath gno.land/r/demo/position -func Mint -args "gno.land/r/demo/gns" -args "gno.land/r/demo/qux" -args 100 -args 22028 -args 24028 -args 1000000000 -args 1000000000000 -args 0 -args 0 -args $(TX_EXPIRE) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null
	@echo


done:
	$(info ************ [DONE] send 1ugnot to gov ************)
	@echo "" | gnokey maketx send -send 1ugnot -to $(ADDR_GOV) -insecure-password-stdin=true -remote $(GNOLAND_RPC_URL) -broadcast=true -chainid $(CHAINID) -gas-fee 1ugnot -gas-wanted 9000000 -memo "" test1 > /dev/null

