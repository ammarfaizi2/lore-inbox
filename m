Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBUPVh>; Wed, 21 Feb 2001 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbRBUPV1>; Wed, 21 Feb 2001 10:21:27 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:59973 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129111AbRBUPVR>; Wed, 21 Feb 2001 10:21:17 -0500
Date: Wed, 21 Feb 2001 16:28:59 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Alan Cox <alan@irongate.swansea.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] 3 of them, resubmit, over 2.4.1-ac20
In-Reply-To: <200102211408.f1LE8pX10950@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0102211626350.884-400000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463800575-1623871019-982769339=:884"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463800575-1623871019-982769339=:884
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 21 Feb 2001, Alan Cox wrote:

> 
> Care to include the actual patches tho..
> 

Argh! Brain damage... Sorry...

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

---1463800575-1623871019-982769339=:884
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ac20-redundant-cpp-directive.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0102211628590.884@toy.mandrakesoft.com>
Content-Description: patch 1
Content-Disposition: attachment; filename="ac20-redundant-cpp-directive.patch"

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvaXJxLmMub2xkCVdlZCBGZWIg
MjEgMTU6NTA6NTAgMjAwMQ0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwv
aXJxLmMJV2VkIEZlYiAyMSAxNTo1MToyMyAyMDAxDQpAQCAtMTA4MCw3ICsx
MDgwLDYgQEANCiANCiAJZXJyID0gcGFyc2VfaGV4X3ZhbHVlKGJ1ZmZlciwg
Y291bnQsICZuZXdfdmFsdWUpOw0KIA0KLSNpZiBDT05GSUdfU01QDQogCS8q
DQogCSAqIERvIG5vdCBhbGxvdyBkaXNhYmxpbmcgSVJRcyBjb21wbGV0ZWx5
IC0gaXQncyBhIHRvbyBlYXN5DQogCSAqIHdheSB0byBtYWtlIHRoZSBzeXN0
ZW0gdW51c2FibGUgYWNjaWRlbnRhbGx5IDotKSBBdCBsZWFzdA0KQEAgLTEw
ODgsNyArMTA4Nyw2IEBADQogCSAqLw0KIAlpZiAoIShuZXdfdmFsdWUgJiBj
cHVfb25saW5lX21hcCkpDQogCQlyZXR1cm4gLUVJTlZBTDsNCi0jZW5kaWYN
CiANCiAJaXJxX2FmZmluaXR5W2lycV0gPSBuZXdfdmFsdWU7DQogCWlycV9k
ZXNjW2lycV0uaGFuZGxlci0+c2V0X2FmZmluaXR5KGlycSwgbmV3X3ZhbHVl
KTsNCg==
---1463800575-1623871019-982769339=:884
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ac20-lockdoor-ioctl.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0102211628591.884@toy.mandrakesoft.com>
Content-Description: patch 2
Content-Disposition: attachment; filename="ac20-lockdoor-ioctl.patch"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS1mbG9wcHkuYy5vbGQJV2VkIEZl
YiAyMSAxNTo1MzoyMCAyMDAxDQorKysgbGludXgvZHJpdmVycy9pZGUvaWRl
LWZsb3BweS5jCVdlZCBGZWIgMjEgMTU6NTU6MjMgMjAwMQ0KQEAgLTE1MTcs
MTUgKzE1MTcsMjEgQEANCiAJCQkJIHVuc2lnbmVkIGludCBjbWQsIHVuc2ln
bmVkIGxvbmcgYXJnKQ0KIHsNCiAJaWRlZmxvcHB5X3BjX3QgcGM7DQorCWlu
dCBwcmV2ZW50ID0gKGFyZykgPyAxIDogMDsNCiANCiAJc3dpdGNoIChjbWQp
IHsNCiAJY2FzZSBDRFJPTUVKRUNUOg0KKwkJcHJldmVudCA9IDA7DQorCQkv
KiBmYWxsIHRocm91Z2ggKi8NCisJY2FzZSBDRFJPTV9MT0NLRE9PUjoNCiAJ
CWlmIChkcml2ZS0+dXNhZ2UgPiAxKQ0KIAkJCXJldHVybiAtRUJVU1k7DQot
CQlpZGVmbG9wcHlfY3JlYXRlX3ByZXZlbnRfY21kICgmcGMsIDApOw0KLQkJ
KHZvaWQpIGlkZWZsb3BweV9xdWV1ZV9wY190YWlsIChkcml2ZSwgJnBjKTsN
Ci0JCWlkZWZsb3BweV9jcmVhdGVfc3RhcnRfc3RvcF9jbWQgKCZwYywgMik7
DQorCQlpZGVmbG9wcHlfY3JlYXRlX3ByZXZlbnRfY21kICgmcGMsIHByZXZl
bnQpOw0KIAkJKHZvaWQpIGlkZWZsb3BweV9xdWV1ZV9wY190YWlsIChkcml2
ZSwgJnBjKTsNCisJCWlmIChjbWQgPT0gQ0RST01FSkVDVCkgew0KKwkJCWlk
ZWZsb3BweV9jcmVhdGVfc3RhcnRfc3RvcF9jbWQgKCZwYywgMik7DQorCQkJ
KHZvaWQpIGlkZWZsb3BweV9xdWV1ZV9wY190YWlsIChkcml2ZSwgJnBjKTsN
CisJCX0NCiAJCXJldHVybiAwOw0KIAljYXNlIElERUZMT1BQWV9JT0NUTF9G
T1JNQVRfU1VQUE9SVEVEOg0KIAkJcmV0dXJuICgwKTsNCg==
---1463800575-1623871019-982769339=:884
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ac20-spurious-assignment.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0102211628592.884@toy.mandrakesoft.com>
Content-Description: patch 3
Content-Disposition: attachment; filename="ac20-spurious-assignment.patch"

LS0tIGxpbnV4L21tL3ZtYWxsb2MuYy5vbGQJV2VkIEZlYiAyMSAxNTo1Njoy
MCAyMDAxDQorKysgbGludXgvbW0vdm1hbGxvYy5jCVdlZCBGZWIgMjEgMTU6
NTg6MDUgMjAwMQ0KQEAgLTE1MSw3ICsxNTEsNiBAQA0KIAkJaWYgKCFwbWQp
DQogCQkJYnJlYWs7DQogDQotCQlyZXQgPSAtRU5PTUVNOw0KIAkJaWYgKGFs
bG9jX2FyZWFfcG1kKHBtZCwgYWRkcmVzcywgZW5kIC0gYWRkcmVzcywgZ2Zw
X21hc2ssIHByb3QpKQ0KIAkJCWJyZWFrOw0KIA0K
---1463800575-1623871019-982769339=:884--
