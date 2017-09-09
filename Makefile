NAME = stepsaway/baseimage
VERSION = 2.1.1

.PHONY: all build_all clean clean_images \
	build_elixir151 \
	release test

all: build_all

build_all: \
	build_elixir151

build_elixir151:
	rm -rf elixir151_image
	cp -pR image elixir151_image
	echo elixir151=1 >> elixir151_image/buildconfig
	echo final=1 >> elixir151_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" elixir151_image/Dockerfile
	docker build -t $(NAME)-elixir15:1-$(VERSION) --rm elixir151_image

clean:
	rm -rf elixir151_image

clean_images:
	@if docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-elixir15:1-$(VERSION) || true; fi

release: test
	@if ! docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F 1-$(VERSION); then echo "$(NAME)-elixir15:1-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)-elixir15:1-$(VERSION)
	@echo "*** Don't forget to create a tag. git tag $(VERSION) && git push origin $(VERSION)"

test:
	@if docker images $(NAME)-elixir15:1-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-elixir15:1 ELIXIR='1.5.1' VERSION=$(VERSION) ./test/runner.sh; fi
