stac-fastapi-pgstac: stac-fastapi
	./breakout.sh stac-fastapi . pgstac

stac-fastapi-sqlalchemy: stac-fastapi
	./breakout.sh stac-fastapi . sqlalchemy

stac-fastapi:
	git clone --single-branch https://github.com/stac-utils/stac-fastapi
