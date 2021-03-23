#help:
#	@printf "\033[32mERoboshop Shell Scripting v$(version)\033[0m\n\n"
#	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
#
#common:
#	@sh components/common.sh
#.PHONY: frontend
#frontend: common		##Install frontend component
#	@sudo sh components/frontend.sh
#
#mongodb: common			##Install mongodb component
#	@sudo sh components/mongodb.sh
#
#catalogue: common		##Install catalogue component
#	@sh components/catalogue.sh
#
#redis: common
#	@sudo sh components/redis.sh
#
#user: common
#	@sudo sh components/user.sh
#
#cart: common
#	@sh components/cart.sh
#
#mysql: common
#	@sudo sh components/mysql.sh
#
#shipping: common
#	@sudo sh components/shipping.sh
#
#rabbitmq: common
#	@sudo sh components/rabbitmq.sh
#
#payment: common
#	@sh compoennts/payment.sh

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

common:
	@sh components/common.sh

cart: common
cart:				## Install Cart Component
	@sh components/cart.sh

catalogue: common
catalogue:			## Install Catalogue Component
	@sh components/catalogue.sh

frontend: common
frontend:			## Install Frontend Component
	@sh components/frontend.sh

mongodb: common
mongodb:			## Install MongoDB Component
	@sh components/mongodb.sh

redis: common
redis:			## Install Redis Component
	@sh components/redis.sh

user: common
user:			## Install User Component
	@sh components/user.sh

mysql: common
mysql:			## Install MySQL Component
	@sh components/mysql.sh

shipping: common
shipping:			## Install Shippinf Component
	@sh components/shipping.sh

rabbitmq: common
rabbitmq:			## Install RabbitMQ Component
	@sh components/rabbitmq.sh

payment: common
payment:			## Install Payment Component
	@sh components/payment.sh