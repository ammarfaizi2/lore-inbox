Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVBWXcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVBWXcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVBWX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:29:56 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:44936 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261676AbVBWX1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:27:24 -0500
Message-ID: <421D1113.9030502@pobox.com>
Date: Wed, 23 Feb 2005 18:26:11 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11+ sata_qstor] libata: sata_qstor cosmetic fixes
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru>
In-Reply-To: <200502232345.23666.adobriyan@mail.ru>
Content-Type: multipart/mixed;
 boundary="------------020009050004030100040401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020009050004030100040401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Minor patch for new 2.6.xx sata_qstor driver attached,
as per Alexey's fine-toothed comb!  :)

Signed-off-by: Mark Lord <mlord@pobox.com>

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


--------------020009050004030100040401
Content-Type: text/plain;
 name="sata_qstor.patch1"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sata_qstor.patch1"

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9zYXRhX3FzdG9yLmMub3JpZwkyMDA1LTAyLTE2IDIw
OjMxOjU3LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgvZHJpdmVycy9zY3NpL3NhdGFfcXN0
b3IuYwkyMDA1LTAyLTIzIDE4OjE5OjMxLjAwMDAwMDAwMCAtMDUwMApAQCAtMjYxLDExICsy
NjEsMTEgQEAKIAkJdTMyIGxlbjsKIAogCQlhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwot
CQkqKHU2NCAqKXByZCA9IGNwdV90b19sZTY0KGFkZHIpOworCQkqKF9fbGU2NCAqKXByZCA9
IGNwdV90b19sZTY0KGFkZHIpOwogCQlwcmQgKz0gc2l6ZW9mKHU2NCk7CiAKIAkJbGVuID0g
c2dfZG1hX2xlbihzZyk7Ci0JCSoodTMyICopcHJkID0gY3B1X3RvX2xlMzIobGVuKTsKKwkJ
KihfX2xlMzIgKilwcmQgPSBjcHVfdG9fbGUzMihsZW4pOwogCQlwcmQgKz0gc2l6ZW9mKHU2
NCk7CiAKIAkJVlBSSU5USygiUFJEWyV1XSA9ICgweCVsbFgsIDB4JVgpXG4iLCBuZWxlbSwK
QEAgLTI5OCwxMCArMjk4LDEwIEBACiAJLyogaG9zdCBjb250cm9sIGJsb2NrIChIQ0IpICov
CiAJYnVmWyAwXSA9IFFTX0hDQl9IRFI7CiAJYnVmWyAxXSA9IGhmbGFnczsKLQkqKHUzMiAq
KSgmYnVmWyA0XSkgPSBjcHVfdG9fbGUzMihxYy0+bnNlY3QgKiBBVEFfU0VDVF9TSVpFKTsK
LQkqKHUzMiAqKSgmYnVmWyA4XSkgPSBjcHVfdG9fbGUzMihxYy0+bl9lbGVtKTsKKwkqKF9f
bGUzMiAqKSgmYnVmWyA0XSkgPSBjcHVfdG9fbGUzMihxYy0+bnNlY3QgKiBBVEFfU0VDVF9T
SVpFKTsKKwkqKF9fbGUzMiAqKSgmYnVmWyA4XSkgPSBjcHVfdG9fbGUzMihxYy0+bl9lbGVt
KTsKIAlhZGRyID0gKCh1NjQpcHAtPnBrdF9kbWEpICsgUVNfQ1BCX0JZVEVTOwotCSoodTY0
ICopKCZidWZbMTZdKSA9IGNwdV90b19sZTY0KGFkZHIpOworCSooX19sZTY0ICopKCZidWZb
MTZdKSA9IGNwdV90b19sZTY0KGFkZHIpOwogCiAJLyogZGV2aWNlIGNvbnRyb2wgYmxvY2sg
KERDQikgKi8KIAlidWZbMjRdID0gUVNfRENCX0hEUjsKQEAgLTU2NiwxMCArNTY2LDEwIEBA
CiAJaW50IHJjLCBoYXZlXzY0Yml0X2J1cyA9IChidXNfaW5mbyAmIFFTX0hQSFlfNjRCSVQp
OwogCiAJaWYgKGhhdmVfNjRiaXRfYnVzICYmCi0JICAgICFwY2lfc2V0X2RtYV9tYXNrKHBk
ZXYsIDB4ZmZmZmZmZmZmZmZmZmZmZlVMTCkpIHsKLQkJcmMgPSBwY2lfc2V0X2NvbnNpc3Rl
bnRfZG1hX21hc2socGRldiwgMHhmZmZmZmZmZmZmZmZmZmZmVUxMKTsKKwkgICAgIXBjaV9z
ZXRfZG1hX21hc2socGRldiwgRE1BXzY0QklUX01BU0spKSB7CisJCXJjID0gcGNpX3NldF9j
b25zaXN0ZW50X2RtYV9tYXNrKHBkZXYsIERNQV82NEJJVF9NQVNLKTsKIAkJaWYgKHJjKSB7
Ci0JCQlyYyA9IHBjaV9zZXRfY29uc2lzdGVudF9kbWFfbWFzayhwZGV2LCAweGZmZmZmZmZm
VUxMKTsKKwkJCXJjID0gcGNpX3NldF9jb25zaXN0ZW50X2RtYV9tYXNrKHBkZXYsIERNQV8z
MkJJVF9NQVNLKTsKIAkJCWlmIChyYykgewogCQkJCXByaW50ayhLRVJOX0VSUiBEUlZfTkFN
RQogCQkJCQkiKCVzKTogNjQtYml0IERNQSBlbmFibGUgZmFpbGVkXG4iLApAQCAtNTc4LDE0
ICs1NzgsMTQgQEAKIAkJCX0KIAkJfQogCX0gZWxzZSB7Ci0JCXJjID0gcGNpX3NldF9kbWFf
bWFzayhwZGV2LCAweGZmZmZmZmZmVUxMKTsKKwkJcmMgPSBwY2lfc2V0X2RtYV9tYXNrKHBk
ZXYsIERNQV8zMkJJVF9NQVNLKTsKIAkJaWYgKHJjKSB7CiAJCQlwcmludGsoS0VSTl9FUlIg
RFJWX05BTUUKIAkJCQkiKCVzKTogMzItYml0IERNQSBlbmFibGUgZmFpbGVkXG4iLAogCQkJ
CXBjaV9uYW1lKHBkZXYpKTsKIAkJCXJldHVybiByYzsKIAkJfQotCQlyYyA9IHBjaV9zZXRf
Y29uc2lzdGVudF9kbWFfbWFzayhwZGV2LCAweGZmZmZmZmZmVUxMKTsKKwkJcmMgPSBwY2lf
c2V0X2NvbnNpc3RlbnRfZG1hX21hc2socGRldiwgRE1BXzMyQklUX01BU0spOwogCQlpZiAo
cmMpIHsKIAkJCXByaW50ayhLRVJOX0VSUiBEUlZfTkFNRQogCQkJCSIoJXMpOiAzMi1iaXQg
Y29uc2lzdGVudCBETUEgZW5hYmxlIGZhaWxlZFxuIiwK
--------------020009050004030100040401--
