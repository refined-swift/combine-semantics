#!/bin/bash

directory=$(cd $(dirname ${0});pwd)
gyb="${directory}/vendored/gyb"
mkdir -p ${gyb}
curl https://raw.githubusercontent.com/apple/swift/main/utils/gyb > ${gyb}/gyb
curl https://raw.githubusercontent.com/apple/swift/main/utils/gyb.py > ${gyb}/gyb.py
curl https://raw.githubusercontent.com/apple/swift/main/utils/SwiftIntTypes.py > ${gyb}/SwiftIntTypes.py
curl https://raw.githubusercontent.com/apple/swift/main/utils/SwiftFloatingPointTypes.py > ${gyb}/SwiftFloatingPointTypes.py
curl https://raw.githubusercontent.com/apple/swift/main/utils/gyb_stdlib_support.py > ${gyb}/gyb_stdlib_support.py
curl https://raw.githubusercontent.com/apple/swift/main/utils/gyb_foundation_support.py > ${gyb}/gyb_foundation_support.py
chmod +x ${gyb}/gyb

