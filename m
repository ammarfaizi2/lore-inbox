Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSFYUNG>; Tue, 25 Jun 2002 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSFYUNF>; Tue, 25 Jun 2002 16:13:05 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:58127 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S315525AbSFYUNE>;
	Tue, 25 Jun 2002 16:13:04 -0400
Date: Tue, 25 Jun 2002 22:13:02 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix modular ide unresolved dependences
Message-ID: <Pine.LNX.4.44L.0206252210410.23072-200000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1473552907-1803414721-1025035982=:23072"
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1473552907-1803414721-1025035982=:23072
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch is adding 2 SYMBOL_EXPORT to device.c, needed by modular 
ide_disk

Witold Krecicki

--1473552907-1803414721-1025035982=:23072
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-ide_exports
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L.0206252213020.23072@ep09.kernel.pl>
Content-Description: 
Content-Disposition: attachment; filename=patch-ide_exports

LS0tIGxpbnV4LTIuNS4yNC9kcml2ZXJzL2lkZS9kZXZpY2UuY34JVHVlIEp1
biAyNSAyMToyNjo1NiAyMDAyDQorKysgbGludXgtMi41LjI0L2RyaXZlcnMv
aWRlL2RldmljZS5jCVR1ZSBKdW4gMjUgMjE6MjY6NTYgMjAwMg0KQEAgLTc5
LDYgKzc5LDggQEANCiAJCWNoLT5tYXNrcHJvYyhkcml2ZSk7DQogfQ0KIA0K
K0VYUE9SVF9TWU1CT0woYXRhX21hc2spOw0KKw0KIC8qDQogICogU3BpbiB1
bnRpbCB0aGUgZHJpdmUgaXMgbm8gbG9uZ2VyIGJ1c3kuDQogICoNCkBAIC0y
MzIsNiArMjM0LDggQEANCiAJT1VUX0JZVEUocmYtPmhpZ2hfY3lsaW5kZXIs
IGNoLT5pb19wb3J0c1tJREVfSENZTF9PRkZTRVRdKTsNCiB9DQogDQorRVhQ
T1JUX1NZTUJPTChhdGFfb3V0X3JlZ2ZpbGUpOw0KKw0KIC8qDQogICogSW5w
dXQgYSBjb21wbGV0ZSByZWdpc3RlciBmaWxlLg0KICAqLw0K
--1473552907-1803414721-1025035982=:23072--

