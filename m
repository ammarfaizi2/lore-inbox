Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRDPQvJ>; Mon, 16 Apr 2001 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRDPQu7>; Mon, 16 Apr 2001 12:50:59 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:50696
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131590AbRDPQuu>; Mon, 16 Apr 2001 12:50:50 -0400
Date: Mon, 16 Apr 2001 09:50:40 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dan Hollis <goemon@anime.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: via udma100 fix
In-Reply-To: <Pine.LNX.4.30.0104160332110.22251-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10104160950000.19043-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1019260510-1751860371-987439840=:19043"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1019260510-1751860371-987439840=:19043
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Apr 2001, Dan Hollis wrote:

> I don't know if anyone noticed, but the supposed udma100 fix has been
> posted here:
> 
> http://www.viahardware.com/download/viatweak.shtm
> 
> At the bottom of the page.
> 
> Technical discussion of the workaround (in german):
> http://home.tiscalinet.de/au-ja/review-kt133a-4.html
> 
> -Dan

Hi Dan,

This was sent to me the other day, is this waht you are talking about?

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

---1019260510-1751860371-987439840=:19043
Content-Type: text/plain; charset=us-ascii; name=PCILatencyPatch
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10104160950400.19043@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename=PCILatencyPatch

LS0tIGxpbnV4LTIuNC4zL2RyaXZlcnMvcGNpL3F1aXJrcy5jLmtpY2tlcglT
dW4gQXByIDE1IDIwOjM4OjQyIDIwMDENCisrKyBsaW51eC0yLjQuMy9kcml2
ZXJzL3BjaS9xdWlya3MuYwlTdW4gQXByIDE1IDIxOjIwOjQ5IDIwMDENCkBA
IC04NSw2ICs4NSwyOSBAQA0KIH0NCiANCiAvKg0KKyAqCVZJQSBBcG9sbG8g
S1QxMzMgbmVlZHMgUENJIGxhdGVuY3kgcGF0Y2gNCisgKglNYWRlIGFjY29y
ZGluZyB0byBhIHdpbmRvd3MgZHJpdmVyIGJhc2VkIHBhdGNoIGJ5IEdlb3Jn
ZSBFLiBCcmVlc2UNCisgKglzZWUgUENJIExhdGVuY3kgQWRqdXN0IG9uIGh0
dHA6Ly93d3cudmlhaGFyZHdhcmUuY29tL2Rvd25sb2FkL3ZpYXR3ZWFrLnNo
dG0NCisgKi8NCitzdGF0aWMgdm9pZCBfX2luaXQgcXVpcmtfdmlhbGF0ZW5j
eShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KK3sNCisJdTggcjcwOw0KKw0KKwlw
cmludGsoS0VSTl9JTkZPICJBcHBseWluZyBWSUEgUENJIGxhdGVuY3kgcGF0
Y2guXG4iKTsNCisJLyoNCisJICogICAgSW4gcmVnaXN0ZXIgMHg3MCwgbWFz
ayBvZmYgYml0IDIgKFBDSSBNYXN0ZXIgcmVhZCBjYWNoaW5nKQ0KKwkgKiAg
ICBhbmQgMSAoRGVsYXkgVHJhbnNhY3Rpb24pDQorCSAqLw0KKwlwY2lfcmVh
ZF9jb25maWdfYnl0ZShkZXYsIDB4NzAsICZyNzApOw0KKwlyNzAgJj0gMHhm
OTsNCisJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRldiwgMHg3MCwgcjcwKTsN
CisJLyoNCisJICogICAgVHVybiBvZmYgUENJIExhdGVuY3kgdGltZW91dCAo
c2V0IHRvIDAgY2xvY2tzKQ0KKwkgKi8NCisJcGNpX3dyaXRlX2NvbmZpZ19i
eXRlKGRldiwgMHg3NSwgMHg4MCk7DQorfQ0KKw0KKy8qDQogICoJVklBIEFw
b2xsbyBWUDMgbmVlZHMgRVRCRiBvbiBCVDg0OC84NzgNCiAgKi8NCiAgDQpA
QCAtMjc1LDYgKzI5OCw3IEBADQogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lf
VkVORE9SX0lEX0lOVEVMLCAJUENJX0RFVklDRV9JRF9JTlRFTF84MjQ0M0JY
XzIsIAlxdWlya19uYXRvbWEgfSwNCiAJeyBQQ0lfRklYVVBfRklOQUwsCVBD
SV9WRU5ET1JfSURfU0ksCVBDSV9ERVZJQ0VfSURfU0lfNTU5NywJCXF1aXJr
X25vcGNpcGNpIH0sDQogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9S
X0lEX1NJLAlQQ0lfREVWSUNFX0lEX1NJXzQ5NiwJCXF1aXJrX25vcGNpcGNp
IH0sDQorCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJ
UENJX0RFVklDRV9JRF9WSUFfODM2M18wLAlxdWlya192aWFsYXRlbmN5IH0s
DQogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1ZJQSwJUENJ
X0RFVklDRV9JRF9WSUFfODJDNTk3XzAsCXF1aXJrX3ZpYWV0YmYgfSwNCiAJ
eyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1ZJQSwJUENJX0RF
VklDRV9JRF9WSUFfODJDNTk3XzAsCXF1aXJrX3Z0ODJjNTk4X2lkIH0sDQog
CXsgUENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9E
RVZJQ0VfSURfVklBXzgyQzU4Nl8zLAlxdWlya192dDgyYzU4Nl9hY3BpIH0s
DQo=
---1019260510-1751860371-987439840=:19043--
