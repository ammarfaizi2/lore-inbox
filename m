Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131924AbQKQLKK>; Fri, 17 Nov 2000 06:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131980AbQKQLKA>; Fri, 17 Nov 2000 06:10:00 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:43769 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131924AbQKQLJx>; Fri, 17 Nov 2000 06:09:53 -0500
Date: Fri, 17 Nov 2000 10:39:53 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Correction.PATCH: 2.4.0-test11-pre6 NTFS: new_inode namespace clash fix
Message-ID: <Pine.SOL.3.96.1001117103807.14106C-200000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-974457484=:14106"
Content-ID: <Pine.SOL.3.96.1001117103807.14106D@libra.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-974457484=:14106
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.96.1001117103807.14106E@libra.cus.cam.ac.uk>

Attached is a corrected version of the previous patch. Goes to show I
should check even obvious looking patches before posting...

Apologies,

Anton


-- 

Anton Altaparmakov       Phone: +44-(0)1223-333541 (lab)
Christ's College         eMail: AntonA@bigfoot.com
Cambridge CB2 3BU          WWW: http://www-stu.christs.cam.ac.uk/~aia21/
United Kingdom             ICQ: 8561279

---559023410-1804928587-974457484=:14106
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ntfs_new_inode.2nd_diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1001117103804.14106B@libra.cus.cam.ac.uk>
Content-Description: 

ZGlmZiAtdXIgbGludXgtMi40LjAtdGVzdDExLXByZTYvZnMvbnRmcy9pbm9k
ZS5jIGxpbnV4L2ZzL250ZnMvaW5vZGUuYw0KLS0tIGxpbnV4LTIuNC4wLXRl
c3QxMS1wcmU2L2ZzL250ZnMvaW5vZGUuYwlXZWQgSnVuIDIxIDE4OjEwOjAy
IDIwMDANCisrKyBsaW51eC9mcy9udGZzL2lub2RlLmMJRnJpIE5vdiAxNyAx
MTowODozMiAyMDAwDQpAQCAtMTA1MCw3ICsxMDUwLDcgQEANCiANCiAvKiBX
ZSBoYXZlIHRvIHNraXAgdGhlIDE2IG1ldGFmaWxlcyBhbmQgdGhlIDggcmVz
ZXJ2ZWQgZW50cmllcyAqLw0KIHN0YXRpYyBpbnQgDQotbmV3X2lub2RlIChu
dGZzX3ZvbHVtZSogdm9sLGludCogcmVzdWx0KQ0KK250ZnNfbmV3X2lub2Rl
IChudGZzX3ZvbHVtZSogdm9sLGludCogcmVzdWx0KQ0KIHsNCiAJaW50IGJ5
dGUsZXJyb3I7DQogCWludCBiaXQ7DQpAQCAtMTIzNiwxMSArMTIzNiwxMSBA
QA0KIAludGZzX3ZvbHVtZSogdm9sPWRpci0+dm9sOw0KIAlpbnQgYnl0ZSxi
aXQ7DQogDQotCWVycm9yPW5ld19pbm9kZSAodm9sLCYocmVzdWx0LT5pX251
bWJlcikpOw0KKwllcnJvcj1udGZzX25ld19pbm9kZSAodm9sLCYocmVzdWx0
LT5pX251bWJlcikpOw0KIAlpZihlcnJvcj09RU5PU1BDKXsNCiAJCWVycm9y
PW50ZnNfZXh0ZW5kX21mdCh2b2wpOw0KIAkJaWYoZXJyb3IpcmV0dXJuIGVy
cm9yOw0KLQkJZXJyb3I9bmV3X2lub2RlKHZvbCwmKHJlc3VsdC0+aV9udW1i
ZXIpKTsNCisJCWVycm9yPW50ZnNfbmV3X2lub2RlKHZvbCwmKHJlc3VsdC0+
aV9udW1iZXIpKTsNCiAJfQ0KIAlpZihlcnJvcil7DQogCQludGZzX2Vycm9y
ICgibnRmc19nZXRfZW1wdHlfaW5vZGU6IG5vIGZyZWUgaW5vZGVzXG4iKTsN
Cg==
---559023410-1804928587-974457484=:14106--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
