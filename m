Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUJ0JiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUJ0JiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbUJ0JiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:38:16 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:38336 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262357AbUJ0JhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:37:09 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [4/10]
Date: Wed, 27 Oct 2004 12:35:29 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098869729820_vwFz99,N.e"
Message-Id: <20041027093529.JYPX6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098869729820_vwFz99,N.e
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[4/10] DAC960, firmware/alpha patch. in 2.6.


------=____1098869729820_vwFz99,N.e
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="DAC960-firmware.patch"
Content-Disposition: inline;
	filename="DAC960-firmware.patch"

CmZyb20gLWFjIC8gcmVkaGF0CkFscmVhZHkgaW4gMi42CgpkaWZmIC11ck4gbGludXgtMi40LjI3
LXByZTIvZHJpdmVycy9ibG9jay9EQUM5NjAuYyBsaW51eC0yLjQuMjctcHJlMi1wYWMxL2RyaXZl
cnMvYmxvY2svREFDOTYwLmMKLS0tIGxpbnV4LTIuNC4yNy1wcmUyL2RyaXZlcnMvYmxvY2svREFD
OTYwLmMJMjAwMi0xMS0yOCAyMzo1MzoxMi4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LTIuNC4y
Ny1wcmUyLXBhYzEvZHJpdmVycy9ibG9jay9EQUM5NjAuYwkyMDA0LTA1LTA1IDE1OjQ4OjQyLjAw
MDAwMDAwMCArMDAwMApAQCAtMTEzMyw2ICsxMTMzLDI2IEBACiAgICAgREFDOTYwUFUvUEQvUEwJ
ICAgIDMuNTEgYW5kIGFib3ZlCiAgICAgREFDOTYwUFUvUEQvUEwvUAkgICAgMi43MyBhbmQgYWJv
dmUKICAgKi8KKyNpZiBkZWZpbmVkKF9fYWxwaGFfXykKKyAgLyoKKyAgICBERUMgQWxwaGEgbWFj
aGluZXMgd2VyZSBvZnRlbiBlcXVpcHBlZCB3aXRoIERBQzk2MCBjYXJkcyB0aGF0IHdlcmUKKyAg
ICBPRU1lZCBmcm9tIE15bGV4LCBhbmQgaGFkIHRoZWlyIG93biBjdXN0b20gZmlybXdhcmUuIFZl
cnNpb24gMi43MCwKKyAgICB0aGUgbGFzdCBjdXN0b20gRlcgcmV2aXNpb24gdG8gYmUgcmVsZWFz
ZWQgYnkgREVDIGZvciB0aGVzZSBvbGRlcgorICAgIGNvbnRyb2xsZXJzLCBhcHBlYXJzIHRvIHdv
cmsgcXVpdGUgd2VsbCB3aXRoIHRoaXMgZHJpdmVyLgorCisgICAgQ2FyZHMgdGVzdGVkIHN1Y2Nl
c3NmdWxseSB3ZXJlIHNldmVyYWwgdmVyc2lvbnMgZWFjaCBvZiB0aGUgUEQgYW5kCisgICAgUFUs
IGNhbGxlZCBieSBERUMgdGhlIEtaUFNDIGFuZCBLWlBBQywgcmVzcGVjdGl2ZWx5LCBhbmQgaGF2
aW5nCisgICAgdGhlIE1hbnVmYWN0dXJlciBOdW1iZXJzIChmcm9tIE15bGV4KSwgdXN1YWxseSBv
biBhIHN0aWNrZXIgb24gdGhlCisgICAgYmFjayBvZiB0aGUgYm9hcmQsIG9mOgorCisgICAgS1pQ
U0MJRDA0MDM0NyAoMWNoKSBvciBEMDQwMzQ4ICgyY2gpIG9yIEQwNDAzNDkgKDNjaCkKKyAgICBL
WlBBQwlEMDQwMzk1ICgxY2gpIG9yIEQwNDAzOTYgKDJjaCkgb3IgRDA0MDM5NyAoM2NoKQorICAq
LworIyBkZWZpbmUgRklSTVdBUkVfMjd4ICIyLjcwIgorI2Vsc2UKKyMgZGVmaW5lIEZJUk1XQVJF
XzI3eCAiMi43MyIKKyNlbmRpZgorCiAgIGlmIChFbnF1aXJ5Mi5GaXJtd2FyZUlELk1ham9yVmVy
c2lvbiA9PSAwKQogICAgIHsKICAgICAgIEVucXVpcnkyLkZpcm13YXJlSUQuTWFqb3JWZXJzaW9u
ID0KQEAgLTExNTIsNyArMTE3Miw3IEBACiAJKENvbnRyb2xsZXItPkZpcm13YXJlVmVyc2lvblsw
XSA9PSAnMycgJiYKIAkgc3RyY21wKENvbnRyb2xsZXItPkZpcm13YXJlVmVyc2lvbiwgIjMuNTEi
KSA+PSAwKSB8fAogCShDb250cm9sbGVyLT5GaXJtd2FyZVZlcnNpb25bMF0gPT0gJzInICYmCi0J
IHN0cmNtcChDb250cm9sbGVyLT5GaXJtd2FyZVZlcnNpb24sICIyLjczIikgPj0gMCkpKQorCSBz
dHJjbXAoQ29udHJvbGxlci0+RmlybXdhcmVWZXJzaW9uLCBGSVJNV0FSRV8yN3gpID49IDApKSkK
ICAgICB7CiAgICAgICBEQUM5NjBfRmFpbHVyZShDb250cm9sbGVyLCAiRklSTVdBUkUgVkVSU0lP
TiBWRVJJRklDQVRJT04iKTsKICAgICAgIERBQzk2MF9FcnJvcigiRmlybXdhcmUgVmVyc2lvbiA9
ICclcydcbiIsIENvbnRyb2xsZXIsCg==

------=____1098869729820_vwFz99,N.e--
