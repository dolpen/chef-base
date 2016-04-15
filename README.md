
Base Cookbook
==============

個人用です。CentOS 6+ 専用です。

 * 時刻設定
 * パッケージのアプデ
 * 公開鍵の配置とセキュリティ設定



Requirements
------------

特になし

Attributes
----------

特になし

Usage
-----

`base` を `run_list` に追加してください

```json
{
  "name":"my_ap_node",
  "run_list": [
    "recipe[base]"
  ]
}
```


Contributing
------------
個人用だからあんまり需要ないのでは。。。


License and Authors
-------------------

#### Author(s)

- Author:: dolpen

#### License

```text
MIT License

Copyright (c) 2016 dolpen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

