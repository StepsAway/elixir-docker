NAME = stepsaway/baseimage
VERSION = 2.0.1

.PHONY: all build_all clean clean_images \
	build_elixir132 \
	release test

all: build_all

build_all: \
	build_elixir132
	build_elixir151

build_elixir132:
	rm -rf elixir132_image
	cp -pR image elixir132_image
	echo elixir132=1 >> elixir132_image/buildconfig
	echo final=1 >> elixir132_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" elixir132_image/Dockerfile
	docker build -t $(NAME)-elixir13:2-$(VERSION) --rm elixir132_image

build_elixir151:
	rm -rf elixir151_image
	cp -pR image elixir151_image
	echo elixir151=1 >> elixir151_image/buildconfig
	echo final=1 >> elixir151_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" elixir151_image/Dockerfile
	docker build -t $(NAME)-elixir15:1-$(VERSION) --rm elixir151_image

clean:
	rm -rf elixir132_image
	rm -rf elixir151_image

clean_images:
	@if docker images $(NAME)-elixir13:2-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-elixir13:2-$(VERSION) || true; fi
	@if docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-elixir15:1-$(VERSION) || true; fi

release: test
	@if ! docker images $(NAME)-elixir13:2-$(VERSION) | awk '{ print $$2 }' | grep -q -F 2-$(VERSION); then echo "$(NAME)-elixir13:2-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1-$(VERSION); then echo "$(NAME)-elixir15:1-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)-elixir15:1-$(VERSION)
	@echo "*** Don't forget to create a tag. git tag $(VERSION) && git push origin $(VERSION)"

test:
	@if docker images $(NAME)-elixir13:2-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-elixir13:2 ELIXIR='1.3.2' VERSION=$(VERSION) ./test/runner.sh; fi
	@if docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-elixir15:1 ELIXIR='1.5.1' VERSION=$(VERSION) ./test/runner.sh; fi
