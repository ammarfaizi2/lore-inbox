Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTBOUIn>; Sat, 15 Feb 2003 15:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBOUIn>; Sat, 15 Feb 2003 15:08:43 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:52997 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S265063AbTBOUIl>; Sat, 15 Feb 2003 15:08:41 -0500
Date: Sat, 15 Feb 2003 21:18:37 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] dasd_3990_erp.c typo patch
Message-ID: <Pine.LNX.4.51.0302152117180.13520@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-1930466845-1045340317=:13520"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-1930466845-1045340317=:13520
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

with / wiht typo patch

Like That

*** drivers/s390/block/dasd_3990_erp.c~	Mon Feb 25 20:38:03 2002
--- drivers/s390/block/dasd_3990_erp.c	Sat Feb 15 21:10:56 2003
***************
*** 2809,2815 ****
   *     - exit with permanent error
   *
   * PARAMETER
!  *   erp                ERP which is in progress wiht no retry left
   *
   * RETURN VALUES
   *   erp                modified/additional ERP
--- 2809,2815 ----
   *     - exit with permanent error
   *
   * PARAMETER
!  *   erp                ERP which is in progress with no retry left
   *
   * RETURN VALUES
   *   erp                modified/additional ERP



-----BEGIN GEEK CODE BLOCK-----
VERSION: 3.1
GIT/MU d-- s:- a-- C++ UL++++$ P L++++ E- W- N- K- w--- O! M- V- PS+ PE++
Y+ PGP- t+ 5-- X+ R tv- b DI+ D---- G e++>+++ h! y?
-----END GEEK CODE BLOCK-----
---23717851-1930466845-1045340317=:13520
Content-Type: TEXT/plain; name="dasd_3990_erp.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0302152118360.13520@dns.toxicfilms.tv>
Content-Description: 
Content-Disposition: attachment; filename="dasd_3990_erp.c.diff"

KioqIGRyaXZlcnMvczM5MC9ibG9jay9kYXNkXzM5OTBfZXJwLmN+CU1vbiBG
ZWIgMjUgMjA6Mzg6MDMgMjAwMg0KLS0tIGRyaXZlcnMvczM5MC9ibG9jay9k
YXNkXzM5OTBfZXJwLmMJU2F0IEZlYiAxNSAyMToxMDo1NiAyMDAzDQoqKioq
KioqKioqKioqKioNCioqKiAyODA5LDI4MTUgKioqKg0KICAgKiAgICAgLSBl
eGl0IHdpdGggcGVybWFuZW50IGVycm9yDQogICAqDQogICAqIFBBUkFNRVRF
Ug0KISAgKiAgIGVycCAgICAgICAgICAgICAgICBFUlAgd2hpY2ggaXMgaW4g
cHJvZ3Jlc3Mgd2lodCBubyByZXRyeSBsZWZ0DQogICAqDQogICAqIFJFVFVS
TiBWQUxVRVMNCiAgICogICBlcnAgICAgICAgICAgICAgICAgbW9kaWZpZWQv
YWRkaXRpb25hbCBFUlANCi0tLSAyODA5LDI4MTUgLS0tLQ0KICAgKiAgICAg
LSBleGl0IHdpdGggcGVybWFuZW50IGVycm9yDQogICAqDQogICAqIFBBUkFN
RVRFUg0KISAgKiAgIGVycCAgICAgICAgICAgICAgICBFUlAgd2hpY2ggaXMg
aW4gcHJvZ3Jlc3Mgd2l0aCBubyByZXRyeSBsZWZ0DQogICAqDQogICAqIFJF
VFVSTiBWQUxVRVMNCiAgICogICBlcnAgICAgICAgICAgICAgICAgbW9kaWZp
ZWQvYWRkaXRpb25hbCBFUlANCg==

---23717851-1930466845-1045340317=:13520--
