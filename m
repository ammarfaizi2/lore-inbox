Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUBPOwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265552AbUBPOwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:52:24 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:39126 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265546AbUBPOwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:52:22 -0500
Date: Mon, 16 Feb 2004 14:52:21 +0000
From: DaMouse Networks <damouse@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make use of NAME variable in mconf/gconf
Message-Id: <20040216145221.248cb1fd@EozVul.WORKGROUP>
Organization: DaMouse Networks
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__16_Feb_2004_14_52_21_+0000_2IB9Wf71i6Qb.eaV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__16_Feb_2004_14_52_21_+0000_2IB9Wf71i6Qb.eaV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Ok, I saw you guys putting NAME stuff in the Makefile and it wasn't doing anything so I've put it into gconf/mconf for y'all :)
Hope you like it!

-DaMouse

--Multipart=_Mon__16_Feb_2004_14_52_21_+0000_2IB9Wf71i6Qb.eaV
Content-Type: application/octet-stream;
 name="menuconfig-NAME.patch"
Content-Disposition: attachment;
 filename="menuconfig-NAME.patch"
Content-Transfer-Encoding: base64

LS0tIGEvc2NyaXB0cy9rY29uZmlnL21jb25mLmMJMjAwNC0wMi0xMiAyMjozODoxNS4wMDAwMDAw
MDAgKzAwMDAKKysrIGIvc2NyaXB0cy9rY29uZmlnL21jb25mLmMJMjAwNC0wMi0xNiAxNDozODox
My4wMDAwMDAwMDAgKzAwMDAKQEAgLTc3MCw4ICs3NzAsOCBAQAogCiAJc3ltID0gc3ltX2xvb2t1
cCgiS0VSTkVMUkVMRUFTRSIsIDApOwogCXN5bV9jYWxjX3ZhbHVlKHN5bSk7Ci0Jc3ByaW50Ziht
ZW51X2JhY2t0aXRsZSwgIkxpbnV4IEtlcm5lbCB2JXMgQ29uZmlndXJhdGlvbiIsCi0JCXN5bV9n
ZXRfc3RyaW5nX3ZhbHVlKHN5bSkpOworCXNwcmludGYobWVudV9iYWNrdGl0bGUsICJMaW51eCBL
ZXJuZWwgdiVzIFwiJXNcIiBDb25maWd1cmF0aW9uIiwKKwkJc3ltX2dldF9zdHJpbmdfdmFsdWUo
c3ltKSwgZ2V0ZW52KCJOQU1FIikpOwogCiAJbW9kZSA9IGdldGVudigiTUVOVUNPTkZJR19NT0RF
Iik7CiAJaWYgKG1vZGUpIHsKLS0tIGEvc2NyaXB0cy9rY29uZmlnL2djb25mLmMJMjAwNC0wMi0x
MiAyMjoyODoyNi4wMDAwMDAwMDAgKzAwMDAKKysrIGIvc2NyaXB0cy9rY29uZmlnL2djb25mLmMJ
MjAwNC0wMi0xNiAxNDozNToyMy4wMDAwMDAwMDAgKzAwMDAKQEAgLTI3NSw5ICsyNzUsMTAgQEAK
IAkJCQkJICAvKiJzdHlsZSIsIFBBTkdPX1NUWUxFX09CTElRVUUsICovCiAJCQkJCSAgTlVMTCk7
CiAKLQlzcHJpbnRmKHRpdGxlLCAiTGludXggS2VybmVsIHYlcy4lcy4lcyVzIENvbmZpZ3VyYXRp
b24iLAorCXNwcmludGYodGl0bGUsICJMaW51eCBLZXJuZWwgdiVzLiVzLiVzJXMgXCIlc1wiIENv
bmZpZ3VyYXRpb24iLAogCQlnZXRlbnYoIlZFUlNJT04iKSwgZ2V0ZW52KCJQQVRDSExFVkVMIiks
Ci0JCWdldGVudigiU1VCTEVWRUwiKSwgZ2V0ZW52KCJFWFRSQVZFUlNJT04iKSk7CisJCWdldGVu
digiU1VCTEVWRUwiKSwgZ2V0ZW52KCJFWFRSQVZFUlNJT04iKSwKKwkJZ2V0ZW52KCJOQU1FIikp
OwogCWd0a193aW5kb3dfc2V0X3RpdGxlKEdUS19XSU5ET1cobWFpbl93bmQpLCB0aXRsZSk7CiAK
IAlndGtfd2lkZ2V0X3Nob3cobWFpbl93bmQpOwotLS0gYS9NYWtlZmlsZQkyMDA0LTAyLTE2IDE0
OjQ2OjI3LjAwMDAwMDAwMCArMDAwMAorKysgYi9NYWtlZmlsZQkyMDA0LTAyLTE2IDE0OjQ4OjAz
LjAwMDAwMDAwMCArMDAwMApAQCAtMjgzLDcgKzI4Myw3IEBACiBleHBvcnQJVkVSU0lPTiBQQVRD
SExFVkVMIFNVQkxFVkVMIEVYVFJBVkVSU0lPTiBLRVJORUxSRUxFQVNFIEFSQ0ggXAogCUNPTkZJ
R19TSEVMTCBIT1NUQ0MgSE9TVENGTEFHUyBDUk9TU19DT01QSUxFIEFTIExEIENDIFwKIAlDUFAg
QVIgTk0gU1RSSVAgT0JKQ09QWSBPQkpEVU1QIE1BS0UgQVdLIEdFTktTWU1TIFBFUkwgVVRTX01B
Q0hJTkUgXAotCUhPU1RDWFggSE9TVENYWEZMQUdTIExERkxBR1NfQkxPQiBMREZMQUdTX01PRFVM
RSBDSEVDSworCUhPU1RDWFggSE9TVENYWEZMQUdTIExERkxBR1NfQkxPQiBMREZMQUdTX01PRFVM
RSBDSEVDSyBOQU1FCiAKIGV4cG9ydCBDUFBGTEFHUyBOT1NURElOQ19GTEFHUyBPQkpDT1BZRkxB
R1MgTERGTEFHUwogZXhwb3J0IENGTEFHUyBDRkxBR1NfS0VSTkVMIENGTEFHU19NT0RVTEUgCg==

--Multipart=_Mon__16_Feb_2004_14_52_21_+0000_2IB9Wf71i6Qb.eaV--
