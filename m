Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030760AbWKUJKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030760AbWKUJKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWKUJKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:10:19 -0500
Received: from mga03.intel.com ([143.182.124.21]:8358 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1030760AbWKUJKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:10:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,442,1157353200"; 
   d="gz'50?scan'50,208,50"; a="148749368:sNHT10892600950"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C70D4C.CF8DEE89"
Subject: [PATCH 2.6.19-rc6-git2] EFI: mapping memory region of runtime services when using memmap kernel parameter
Date: Tue, 21 Nov 2006 11:09:55 +0200
Message-ID: <C1467C8B168BCF40ACEC2324C1A2B074A6A6A5@hasmsx411.ger.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc6-git2] EFI: mapping memory region of runtime services when using memmap kernel parameter
Thread-Index: AccNS/jjjas+RVGtQI+1axKdX6QZSQ==
From: "Myaskouvskey, Artiom" <artiom.myaskouvskey@intel.com>
To: <randy.dunlap@oracle.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2006 09:09:55.0975 (UTC) FILETIME=[CFE27970:01C70D4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70D4C.CF8DEE89
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogQXJ0aW9tIE15YXNrb3V2c2tleSA8YXJ0aW9tLm15YXNrb3V2c2tleUBpbnRlbC5jb20+
DQoNCldoZW4gdXNpbmcgbWVtbWFwIGtlcm5lbCBwYXJhbWV0ZXIgaW4gRUZJIGJvb3Qgd2Ugc2hv
dWxkIGFsc28gYWRkIHRvIG1lbW9yeSBtYXAgDQptZW1vcnkgcmVnaW9ucyBvZiBydW50aW1lIHNl
cnZpY2VzIHRvIGVuYWJsZSB0aGVpciBtYXBwaW5nIGxhdGVyLg0KDQpTaWduZWQtb2ZmLWJ5OiBB
cnRpb20gTXlhc2tvdXZza2V5IDxhcnRpb20ubXlhc2tvdXZza2V5QGludGVsLmNvbT4NCi0tLQ0K
DQoNCg==

------_=_NextPart_001_01C70D4C.CF8DEE89
Content-Type: application/x-gtar;
	name="efi-memmap.patch.gz"
Content-Transfer-Encoding: base64
Content-Description: efi-memmap.patch.gz
Content-Disposition: attachment;
	filename="efi-memmap.patch.gz"

H4sICCLBYkUAC2VmaS1tZW1tYXAucGF0Y2gApVZtb9s2EP6sAPkP92mwLUu2nNRJnDhIMThtgOUF
TbuhGwaBkWibiUQKFJXWG/bfd3yRI7vKmnQGbEvkPXcP7x4eeS5FPoG3UjGRw+WKlA+ieiwf6ApO
iBkM88bgGeOKZmEi8tPdnd2d35aUQ1UyvoCc5jkp4IFKTjMoiCQ5VVQC4zA7v4A7IRR8oVAuRZWl
QLJSAElTUEIjhVyBRu/uuBdJF0zwEsQcZMUVyxFJ5SNLaKkhlJO7jIJaUiY1sNAMMoLxQk3rli04
TQMxnwd3qx9cXBAEuztIKGXzOQRVIa8gY7z6GozCcRgdBTIZBwumRqGQbME4yQaMJ1mV0oExG9A5
C5ftkDZLE/AHInij4XAcRFEQHUE0nOwfTPajcFh/wB/i/O6O7/svp7LhMpoMx5O9N9+6PDuDYG84
6o/B138HgAP0K1aAw6NgKaCrmHGmGMnYXzTGXNM8lrQUlUwwsZ7+lEpWiQI3SqGXEkVqI9o9Rjvn
suKlqSlkAisdG88mxIKqWMujo4M2EVjLpl2JdlIlcZ6XZWfTGxdftAcN9htgVsbkkbBMKy22suxo
T/YxTmmZxAp6kG+EdUtqGGpd281xbAQFg17vNbIiMlkO2N7heGD31gCXUhVh8kxBnzN/kcCeA2+r
7HAyGr5GZS/yG01Ge5PRwTNS2z/qj96g1vB/f1+LrVREscSKzRW6kOKOxtjQSisHTHaLVcZyhmKw
HWZLC+anRMFq7N9apy3zSSUl5SrG/iVhCkOsa+AZyWgJ2Sfow72rt8fmYJRju1ba1Y4Dz2sRU54a
X56h2yuMu3a7PvQ4Si7OU8fAX6NwqohsbHQ1FxI6BRpZDYb47SM9DYICThrDyM+F9wrw1wATU6cE
Yb5vyPv/5bZ/b36hiDZmLUWvJSR8J5ruFWaZhWO3lf88DU6L5aq07z509ACv8rggCzwuTk4gGnUd
VJdCT6tVQWE61UdT/PP11a+zq48X11dvf4kvZ5fXHz7Xq/SecmxS6n8/ujXybs6v4pv3n283yXSd
D02jrb9gL1mHXnN98n46tdqEROCZyCvq3HkIT4pVx7Htg/luJdR0qdrvxiLWbq0uTbqbGQym9bjX
6WxAA4vz4ebtu1l8e/H7LIi6cHrq3t9fnH+sM29IakJcmpY4RbX4EK1nJXYEyesF1YnfpmEnTXY/
3bRQqdf4jzNFEbZoq47SUl3v3vfdo/NBs5KCzpkpBlFKsrtKUfjJiMfqJf7wCQV0OeuiptYk26br
2g56cMFByBRvSPoKRB7otxcdZ4tnzFoo+gq1JI9Ug9zRXeOerLfuUHgDa1yxeoNXauZ/5RFsHqHO
5rYG7o+bw64jbPSN9ZbqbGJ7z5FdCwlsZNOpXMNj2H3oIZ5d1slxs8ds7WtjhjZ/sD9Dt7WbQ275
/wJ2npjhPgsAAA==

------_=_NextPart_001_01C70D4C.CF8DEE89--
