Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSH1Eaq>; Wed, 28 Aug 2002 00:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSH1Eap>; Wed, 28 Aug 2002 00:30:45 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:30874 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S318696AbSH1E37>; Wed, 28 Aug 2002 00:29:59 -0400
Date: Wed, 28 Aug 2002 00:34:13 -0400 (EDT)
From: Albert Cranford <ac9410@attbi.com>
X-X-Sender: ac9410@home1
Reply-To: Albert Cranford <ac9410@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.32 blacklist IBM Thinkpads from i2c/sensors
Message-ID: <Pine.LNX.4.44.0208280031250.2193-200000@home1>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1326334787-1030509253=:2193"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1326334787-1030509253=:2193
Content-Type: TEXT/PLAIN; charset=US-ASCII



-- 
ac9410@attbi.com

--0-1326334787-1030509253=:2193
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=89-dmi_scan-patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208280034130.2193@home1>
Content-Description: 
Content-Disposition: attachment; filename=89-dmi_scan-patch

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvZG1pX3NjYW4uYy5vcmlnICAg
ICAyMDAyLTA3LTMxIDIzOjEwOjIxLjAwMDAwMDAwMCAtMDQwMA0KKysrIGxp
bnV4L2FyY2gvaTM4Ni9rZXJuZWwvZG1pX3NjYW4uYwkyMDAyLTA4LTI3IDIy
OjQ1OjEyLjAwMDAwMDAwMCAtMDQwMA0KQEAgLTEyLDYgKzEyLDcgQEANCiAN
CiB1bnNpZ25lZCBsb25nIGRtaV9icm9rZW47DQogaW50IGlzX3NvbnlfdmFp
b19sYXB0b3A7DQoraW50IGlzX3Vuc2FmZV9zbWJ1czsNCiANCiBzdHJ1Y3Qg
ZG1pX2hlYWRlcg0KIHsNCkBAIC00NTksNiArNDYwLDIwIEBADQogCXJldHVy
biAwOw0KIH0NCiANCisvKiANCisgKiBEb24ndCBhY2Nlc3MgU01CdXMgb24g
SUJNIHN5c3RlbXMgd2hpY2ggZ2V0IGNvcnJ1cHRlZCBlZXByb21zIA0KKyAq
Lw0KKw0KK3N0YXRpYyBfX2luaXQgaW50IGRpc2FibGVfc21idXMoc3RydWN0
IGRtaV9ibGFja2xpc3QgKmQpDQorew0KKwlpZiAoaXNfdW5zYWZlX3NtYnVz
ID09IDApDQorCXsNCisJCWlzX3Vuc2FmZV9zbWJ1cyA9IDE7DQorCQlwcmlu
dGsoS0VSTl9JTkZPICIlcyBtYWNoaW5lIGRldGVjdGVkLiBEaXNhYmxpbmcg
U01CdXMgYWNjZXNzZXMuXG4iLCBkLT5pZGVudCk7DQorCX0NCisJcmV0dXJu
IDA7DQorfQ0KKw0KIC8qDQogICoJU2ltcGxlICJwcmludCBpZiB0cnVlIiBj
YWxsYmFjaw0KICAqLw0KQEAgLTczMiw2ICs3NDcsMTUgQEANCiAJCQlOT19N
QVRDSCwgTk9fTUFUQ0gsIE5PX01BVENIDQogCQkJfSB9LA0KIA0KKwkvKg0K
KwkgKglTTUJ1cyAvIHNlbnNvcnMgc2V0dGluZ3MNCisJICovDQorCSANCisJ
eyBkaXNhYmxlX3NtYnVzLCAiSUJNIiwgew0KKwkJCU1BVENIKERNSV9TWVNf
VkVORE9SLCAiSUJNIiksDQorCQkJTk9fTUFUQ0gsIE5PX01BVENILCBOT19N
QVRDSA0KKwkJCX0gfSwNCisNCiAJeyBOVUxMLCB9DQogfTsNCiAJDQo=
--0-1326334787-1030509253=:2193--
