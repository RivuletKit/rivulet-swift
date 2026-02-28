<!--
 * @Author: Bin
 * @Date: 2024-02-16
 * @FilePath: /rivulet-swift/README.md
-->
# rivulet-swift

Swift Library for RivuletKit

## positioning

`rivulet-swift` is a request + response SDK implementation for the unified Rivulet schema.

- Input: unified JSON/protobuf request (`Request`)
- Runtime: Swift SDK executes the request
- Output: normalized protobuf response (`Response`)

Behavior spec (v1): `SPEC.md`

## v1 support matrix

- URL: `raw`, split fields (`protocol/host/path/port/querys`), `disabled` query filtering
- Method: supported, default `GET`
- Headers: supported, `disabled` filtering
- Body:
  - `raw`: supported
  - `urlencoded`: supported
  - `formdata`: supported
  - `file`: supported
  - `graphql`: unsupported in v1
- Auth:
  - `noauth`: supported
  - `basic`: supported
  - `bearer`: supported
  - `apikey`: supported
  - `awsv4/digest/edgegrid/hawk/ntlm/oauth1/oauth2`: unsupported in v1
- Proxy: unsupported in v1
- Certificate: unsupported in v1

For unsupported features, SDK should return explicit errors defined in `SPEC.md`.

## development 💽

```
# install Protocol (if you have installed, please skip)
wget -O protoc.zip  https://github.com/protocolbuffers/protobuf/releases/download/v21.5/protoc-21.5-osx-x86_64.zip  && unzip -d ./protoc/ -o protoc.zip && cp ./protoc/bin/protoc /usr/local/bin/

# use brew install swift-protobuf cil tools
brew install swift-protobuf
```

Protocol Compiler Installation: <https://github.com/protocolbuffers/protobuf#protocol-compiler-installation>

Help Docs: <https://github.com/apple/swift-protobuf/blob/main/Documentation/PLUGIN.md>

## build 🗜

```
git submodule update --init --recursive

# build
protoc -I ./rivulet-proto --swift_opt=Visibility=Public --swift_opt=ProtoPathModuleMappings=./swift_mappings.asciipb --swift_out=./Sources/ ./rivulet-proto/protos/**/*/*.proto
```

## resource 💾

Swift Protobuf: <https://github.com/apple/swift-protobuf>

Swift use Protobuf: <http://bartontang.github.io/2018/01/01/Swift%E4%B8%8B%E4%BD%BF%E7%94%A8Protobuf/>
