Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRIVUrM>; Sat, 22 Sep 2001 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272118AbRIVUrC>; Sat, 22 Sep 2001 16:47:02 -0400
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:53477 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272135AbRIVUqu>; Sat, 22 Sep 2001 16:46:50 -0400
Date: Sat, 22 Sep 2001 16:46:28 -0400 (EDT)
From: Leonid Igolnik <lim@igolnik.com>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <laughing@shared-source.org>
Subject: [PATCH] Linux 2.4.9-ac14
In-Reply-To: <20010922032246.A7730@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0109221644590.9877-200000@home.igolnik.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-172594627-1001191588=:9877"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-172594627-1001191588=:9877
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Small addition to
> o	Fix SEM_UNDO wrap bug				(me, Leonid Igolnik)

Leonid

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7rPimRrKFtN3cJpMRAjLWAKDmWI/xSk5GxMhj7QIz5ETnAVVk/QCfQiKg
u46DXW6ur+ez7vZIPY8Z7zg=
=5gjb
-----END PGP SIGNATURE-----

--8323328-172594627-1001191588=:9877
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.9-ac14.SEMAEM.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109221646280.9877@home.igolnik.com>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4.9-ac14.SEMAEM.patch"

ZGlmZiAtdWIgbGludXguYWMvaXBjL3NlbS5jIGxpbnV4LmxpbS9pcGMvc2Vt
LmMgDQotLS0gbGludXguYWMvaXBjL3NlbS5jCVNhdCBTZXAgMjIgMTY6MTg6
MDMgMjAwMQ0KKysrIGxpbnV4LmxpbS9pcGMvc2VtLmMJU2F0IFNlcCAyMiAx
NjowNzowMSAyMDAxDQpAQCAtMjYzLDcgKzI2Myw3IEBADQogCQkJLyoNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAqICAgICAgRXhjZWVkaW5nIHRoZSB1
bmRvIHJhbmdlIGlzIGFuIGVycm9yLg0KIAkJCSAqLw0KLQkJCWlmKHVuZG8g
PCAtMzI3NjcgfHwgdW5kbyA+IDMyNzY3KQ0KKwkJCWlmICh1bmRvIDwgKC1T
RU1BRU0gLSAxKSB8fCB1bmRvID4gU0VNQUVNKQ0KIAkJCXsNCiAJCQkJLyog
RG9uJ3QgdW5kbyB0aGUgdW5kbyAqLw0KIAkJCQlzb3AtPnNlbV9mbGcgJj0g
flNFTV9VTkRPOw0KZGlmZiAtdWIgbGludXguYWMvaW5jbHVkZS9saW51eC9z
ZW0uaCAgbGludXgubGltL2luY2x1ZGUvbGludXgvc2VtLmgNCi0tLSBsaW51
eC5hYy9pbmNsdWRlL2xpbnV4L3NlbS5oCVdlZCBBdWcgMTUgMTc6MjE6MTEg
MjAwMQ0KKysrIGxpbnV4LmxpbS9pbmNsdWRlL2xpbnV4L3NlbS5oCVNhdCBT
ZXAgMjIgMTU6NTQ6MTcgMjAwMQ0KQEAgLTY4LDExICs2OCwxMSBAQA0KICNk
ZWZpbmUgU0VNTU5TICAoU0VNTU5JKlNFTU1TTCkgLyogPD0gSU5UX01BWCBt
YXggIyBvZiBzZW1hcGhvcmVzIGluIHN5c3RlbSAqLw0KICNkZWZpbmUgU0VN
T1BNICAzMgkgICAgICAgIC8qIDw9IDEgMDAwIG1heCBudW0gb2Ygb3BzIHBl
ciBzZW1vcCBjYWxsICovDQogI2RlZmluZSBTRU1WTVggIDMyNzY3ICAgICAg
ICAgICAvKiA8PSAzMjc2NyBzZW1hcGhvcmUgbWF4aW11bSB2YWx1ZSAqLw0K
KyNkZWZpbmUgU0VNQUVNICBTRU1WTVggICAgICAgICAgLyogYWRqdXN0IG9u
IGV4aXQgbWF4IHZhbHVlICovDQogDQogLyogdW51c2VkICovDQogI2RlZmlu
ZSBTRU1VTUUgIFNFTU9QTSAgICAgICAgICAvKiBtYXggbnVtIG9mIHVuZG8g
ZW50cmllcyBwZXIgcHJvY2VzcyAqLw0KICNkZWZpbmUgU0VNTU5VICBTRU1N
TlMgICAgICAgICAgLyogbnVtIG9mIHVuZG8gc3RydWN0dXJlcyBzeXN0ZW0g
d2lkZSAqLw0KLSNkZWZpbmUgU0VNQUVNICAoU0VNVk1YID4+IDEpICAgLyog
YWRqdXN0IG9uIGV4aXQgbWF4IHZhbHVlICovDQogI2RlZmluZSBTRU1NQVAg
IFNFTU1OUyAgICAgICAgICAvKiAjIG9mIGVudHJpZXMgaW4gc2VtYXBob3Jl
IG1hcCAqLw0KICNkZWZpbmUgU0VNVVNaICAyMAkJLyogc2l6ZW9mIHN0cnVj
dCBzZW1fdW5kbyAqLw0KIA0K
--8323328-172594627-1001191588=:9877--
