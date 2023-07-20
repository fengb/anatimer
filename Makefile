export VERSION = 0.2.1

.PHONY: build/pkg clean

build/v%.tar.gz:
	@mkdir -p build
	curl -fsL -o "$@" "https://github.com/fengb/anatimer/archive/$(@F)"

build/PKGBUILD-v%: build/v%.tar.gz scripts/PKGBUILD.template
	SHA256="$$(shasum -a 256 '$<' | cut -d' ' -f1)" scripts/PKGBUILD.template >"$@"

build/PKGBUILD: build/PKGBUILD-v$(VERSION)
	cp "$<" "$@"

build/pkg: build/PKGBUILD
	docker run --user nobody --volume "$(CURDIR)/build:/build" --workdir "/build" base/devel:2018.08.01 makepkg -d

clean:
	rm -r build
