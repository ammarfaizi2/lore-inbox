Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUJ0Jng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUJ0Jng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUJ0Jnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:43:35 -0400
Received: from fep01.ttnet.net.tr ([212.156.4.129]:62704 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S262351AbUJ0JkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:40:04 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [5/10]
Date: Wed, 27 Oct 2004 12:38:26 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098869906089_pV3?-EX?+a"
Message-Id: <20041027093826.JZPS6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098869906089_pV3?-EX?+a
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[5/10] Alan Cox: appletalk dev copy/user stanford checker patch.

Not in 2.6, only in -ac/redhat. To be reviewed.


------=____1098869906089_pV3?-EX?+a
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="appletalk-dev-copy-user-checker.patch"
Content-Disposition: inline;
	filename="appletalk-dev-copy-user-checker.patch"

CkFsYW4gQ294Cm9ubHkgaW4gLWFjL3JlZGhhdCwgX05PVF8gaW4gMi42LgoKZGlmZiAtdXJOIDI4
cmMxL25ldC9hcHBsZXRhbGsvZGRwLmMgMjhyYzFfYWFjL25ldC9hcHBsZXRhbGsvZGRwLmMKLS0t
IDI4cmMxL25ldC9hcHBsZXRhbGsvZGRwLmMJMjAwNC0xMC0yNCAwMDo0NTo1MS4wMDAwMDAwMDAg
KzAzMDAKKysrIDI4cmMxX2FhYy9uZXQvYXBwbGV0YWxrL2RkcC5jCTIwMDQtMTAtMjQgMDA6NTg6
MTIuMDAwMDAwMDAwICswMzAwCkBAIC05NzgsNiArOTc4LDIzIEBACiAKIAlpZiAoY29weV9mcm9t
X3VzZXIoJnJ0LCBhcmcsIHNpemVvZihydCkpKQogCQlyZXR1cm4gLUVGQVVMVDsKKwkJCisJaWYo
cnQucnRfZGV2KQorCXsKKwkJY2hhciAqY29sb247CisJCXN0cnVjdCBuZXRfZGV2aWNlICpkZXY7
CisJCWNoYXIgICBkZXZuYW1lW0lGTkFNU0laXTsKKworCQlpZiAoY29weV9mcm9tX3VzZXIoZGV2
bmFtZSwgcnQucnRfZGV2LCBJRk5BTVNJWi0xKSkKKwkJCXJldHVybiAtRUZBVUxUOworCQlkZXZu
YW1lW0lGTkFNU0laLTFdID0gMDsKKwkJY29sb24gPSBzdHJjaHIoZGV2bmFtZSwgJzonKTsKKwkJ
aWYgKGNvbG9uKQorCQkJKmNvbG9uID0gMDsKKwkJZGV2ID0gX19kZXZfZ2V0X2J5X25hbWUoZGV2
bmFtZSk7CisJCWlmKGRldiA9PSBOVUxMKQorCQkJcmV0dXJuIC1FTk9ERVY7CisJfQogCiAJc3dp
dGNoIChjbWQpIHsKIAkJY2FzZSBTSU9DREVMUlQ6CkBAIC05ODcsMTMgKzEwMDQsNiBAQAogCQkJ
CQkJJnJ0LnJ0X2RzdCktPnNhdF9hZGRyKTsKIAogCQljYXNlIFNJT0NBRERSVDoKLQkJCS8qIEZJ
WE1FOiB0aGUgbmFtZSBvZiB0aGUgZGV2aWNlIGlzIHN0aWxsIGluIHVzZXIKLQkJCSAqIHNwYWNl
LCBpc24ndCBpdD8gKi8KLQkJCWlmIChydC5ydF9kZXYpIHsKLQkJCQlkZXYgPSBfX2Rldl9nZXRf
YnlfbmFtZShydC5ydF9kZXYpOwotCQkJCWlmICghZGV2KQotCQkJCQlyZXR1cm4gLUVOT0RFVjsK
LQkJCX0JCQkKIAkJCXJldHVybiBhdHJ0cl9jcmVhdGUoJnJ0LCBkZXYpOwogCX0KIAlyZXR1cm4g
LUVJTlZBTDsK

------=____1098869906089_pV3?-EX?+a--
