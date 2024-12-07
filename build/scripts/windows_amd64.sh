# Copyright 2022 Google LLC.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

OutputFolder="./build/bin/windows_amd64"
rm -vrf ./build/bin/windows_amd64
mkdir -vp ./build/bin/windows_amd64

# Build the signer binary
cd internal/signer/windows
go build
mv -v windows.exe ../../../build/bin/windows_amd64/ecp.exe
cd ../../../

# Build the signer library
# TODO: Add build version to shared DLL. https://github.com/googleapis/enterprise-certificate-proxy/issues/103
go build -buildmode=c-shared -o build/bin/windows_amd64/libecp.dll /cshared/main.go
go build -buildmode=c-archive -o build/bin/windows_amd64/libecp.lib ./cshared/main.go

rm -vrf .\build\bin\windows_amd64\libecp.h
