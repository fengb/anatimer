export VERSION = 0.1.0

build/v%.tar.gz:
	@mkdir -p build
	curl -fsL -o "$@" "https://github.com/fengb/anatimer/archive/$(@F)"

build/PKGBUILD-v%: build/v%.tar.gz scripts/PKGBUILD.template
	SHA256="$$(shasum -a 256 '$<' | cut -d' ' -f1)" scripts/PKGBUILD.template >"$@"

build/PKGBUILD: build/PKGBUILD-v$(VERSION)
	cp "$<" "$@"
