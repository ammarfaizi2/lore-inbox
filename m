Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316844AbSE1QlE>; Tue, 28 May 2002 12:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSE1QlD>; Tue, 28 May 2002 12:41:03 -0400
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:31886 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316844AbSE1QlC>; Tue, 28 May 2002 12:41:02 -0400
From: Ghozlane Toumi <ghoz@sympatico.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        MR Trivial <trivial@rustcorp.com.au>
Subject: [patch] mucho trivial update to pci/quirks.c
Date: Tue, 28 May 2002 12:39:56 -0400
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_KAYTB4AW9SVBQFADQSEY"
Message-Id: <20020528164102.NGBA9770.tomts24-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_KAYTB4AW9SVBQFADQSEY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi all,

Attached is a really trivial patch that changes an "unknown" PCI_DEVICE_ID 
0x3112 to PCI_DEVICE_ID_VIA_8361 in drivers/pci/quirks.c .

It applies cleanly to 2.5.18 and 2.4.19-pre8.

Ghoz
--------------Boundary-00=_KAYTB4AW9SVBQFADQSEY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="triv.pci.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="triv.pci.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNS4xOC9kcml2ZXJzL3BjaS9xdWlya3MuYyBsaW51eC0yLjUuMTgt
YS9kcml2ZXJzL3BjaS9xdWlya3MuYwotLS0gbGludXgtMi41LjE4L2RyaXZlcnMvcGNpL3F1aXJr
cy5jCVNhdCBNYXkgMjUgMTk6Mjg6MjIgMjAwMgorKysgbGludXgtMi41LjE4LWEvZHJpdmVycy9w
Y2kvcXVpcmtzLmMJTW9uIE1heSAyNyAxNzozOTo0NCAyMDAyCkBAIC00ODYsNyArNDg2LDcgQEAK
IAl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9TSSwJUENJX0RFVklDRV9JRF9TSV80
OTYsCQlxdWlya19ub3BjaXBjaSB9LAogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lE
X1ZJQSwJUENJX0RFVklDRV9JRF9WSUFfODM2M18wLAlxdWlya192aWFsYXRlbmN5IH0sCiAJeyBQ
Q0lfRklYVVBfRklOQUwsCVBDSV9WRU5ET1JfSURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84Mzcx
XzEsCXF1aXJrX3ZpYWxhdGVuY3kgfSwKLQl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9J
RF9WSUEsCTB4MzExMgkvKiBOb3Qgb3V0IHlldCA/ICovLAlxdWlya192aWFsYXRlbmN5IH0sCisJ
eyBQQ0lfRklYVVBfRklOQUwsCVBDSV9WRU5ET1JfSURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84
MzYxLAlxdWlya192aWFsYXRlbmN5IH0sCiAJeyBQQ0lfRklYVVBfRklOQUwsCVBDSV9WRU5ET1Jf
SURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84MkM1NzYsCXF1aXJrX3ZzZnggfSwKIAl7IFBDSV9G
SVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9WSUEsCVBDSV9ERVZJQ0VfSURfVklBXzgyQzU5N18w
LAlxdWlya192aWFldGJmIH0sCiAJeyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1ZJ
QSwJUENJX0RFVklDRV9JRF9WSUFfODJDNTk3XzAsCXF1aXJrX3Z0ODJjNTk4X2lkIH0sCg==

--------------Boundary-00=_KAYTB4AW9SVBQFADQSEY--
