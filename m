Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319109AbSH2Fjq>; Thu, 29 Aug 2002 01:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319111AbSH2Fjp>; Thu, 29 Aug 2002 01:39:45 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:31625 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S319109AbSH2Fjo>; Thu, 29 Aug 2002 01:39:44 -0400
Date: Thu, 29 Aug 2002 01:44:00 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.20-pre5 DMI blacklist IBM Thinkpad in i2c/sensors
Message-ID: <Pine.LNX.4.44.0208290139460.16793-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1753127640-1030599840=:16793"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1753127640-1030599840=:16793
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Marcelo,
The attached patch add capability to blacklist IBM ThinkPads in i2c/sensors by
updating global variable.
Thanks,
Albert
-- 
ac9410@attbi.com

--0-1753127640-1030599840=:16793
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=89-dmi_scan-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208290144000.16793@home1>
Content-Description: 
Content-Disposition: attachment; filename=89-dmi_scan-patch

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvZG1pX3NjYW4uYy5vcmlnICAg
ICAyMDAyLTA3LTMxIDIzOjEwOjIxLjAwMDAwMDAwMCAtMDQwMA0KKysrIGxp
bnV4L2FyY2gvaTM4Ni9rZXJuZWwvZG1pX3NjYW4uYwkyMDAyLTA4LTE5IDIz
OjUxOjA3LjAwMDAwMDAwMCAtMDQwMA0KQEAgLTEzLDYgKzEzLDcgQEANCiAN
CiB1bnNpZ25lZCBsb25nIGRtaV9icm9rZW47DQogaW50IGlzX3NvbnlfdmFp
b19sYXB0b3A7DQoraW50IGlzX3Vuc2FmZV9zbWJ1czsNCiANCiBzdHJ1Y3Qg
ZG1pX2hlYWRlcg0KIHsNCkBAIC00NzYsNiArNDc3LDIwIEBADQogfQ0KIA0K
IA0KKy8qIA0KKyAqIERvbid0IGFjY2VzcyBTTUJ1cyBvbiBJQk0gc3lzdGVt
cyB3aGljaCBnZXQgY29ycnVwdGVkIGVlcHJvbXMgDQorICovDQorDQorc3Rh
dGljIF9faW5pdCBpbnQgZGlzYWJsZV9zbWJ1cyhzdHJ1Y3QgZG1pX2JsYWNr
bGlzdCAqZCkNCit7DQorCWlmIChpc191bnNhZmVfc21idXMgPT0gMCkNCisJ
ew0KKwkJaXNfdW5zYWZlX3NtYnVzID0gMTsNCisJCXByaW50ayhLRVJOX0lO
Rk8gIiVzIG1hY2hpbmUgZGV0ZWN0ZWQuIERpc2FibGluZyBTTUJ1cyBhY2Nl
c3Nlcy5cbiIsIGQtPmlkZW50KTsNCisJfQ0KKwlyZXR1cm4gMDsNCit9DQor
DQogLyoNCiAgKglTaW1wbGUgInByaW50IGlmIHRydWUiIGNhbGxiYWNrDQog
ICovDQpAQCAtNzY1LDYgKzc4MCwxNSBAQA0KIAkJCU5PX01BVENILCBOT19N
QVRDSCwgTk9fTUFUQ0gNCiAJCQl9IH0sDQogDQorCS8qDQorCSAqCVNNQnVz
IC8gc2Vuc29ycyBzZXR0aW5ncw0KKwkgKi8NCisJIA0KKwl7IGRpc2FibGVf
c21idXMsICJJQk0iLCB7DQorCQkJTUFUQ0goRE1JX1NZU19WRU5ET1IsICJJ
Qk0iKSwNCisJCQlOT19NQVRDSCwgTk9fTUFUQ0gsIE5PX01BVENIDQorCQkJ
fSB9LA0KKw0KIAl7IE5VTEwsIH0NCiB9Ow0KIAkNCg==
--0-1753127640-1030599840=:16793--
