Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbUJ0Jem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbUJ0Jem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUJ0Jel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:34:41 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:3325 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262346AbUJ0Jdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:33:49 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [2/10]
Date: Wed, 27 Oct 2004 12:32:08 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098869528523_2uKa7Jow1-"
Message-Id: <20041027093208.JXNV6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098869528523_2uKa7Jow1-
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[2/10] tun.c sign mishandling


------=____1098869528523_2uKa7Jow1-
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="tun_sign_mishandling.patch"
Content-Disposition: inline;
	filename="tun_sign_mishandling.patch"

CmFscmVhZHkgaW4gMi42CgoKZGlmZiAtdXJOIDI4cmMxL2RyaXZlcnMvbmV0L3R1bi5jIDI4cmMx
X2FhYy9kcml2ZXJzL25ldC90dW4uYwotLS0gMjhyYzEvZHJpdmVycy9uZXQvdHVuLmMJMjAwNC0w
OC0wOCAwMjoyNjowNS4wMDAwMDAwMDAgKzAzMDAKKysrIDI4cmMxX2FhYy9kcml2ZXJzL25ldC90
dW4uYwkyMDA0LTEwLTI0IDAwOjU4OjEwLjAwMDAwMDAwMCArMDMwMApAQCAtMTg4LDcgKzE4OCw3
IEBACiAJc2l6ZV90IGxlbiA9IGNvdW50OwogCiAJaWYgKCEodHVuLT5mbGFncyAmIFRVTl9OT19Q
SSkpIHsKLQkJaWYgKChsZW4gLT0gc2l6ZW9mKHBpKSkgPCAwKQorCQlpZiAoKGxlbiAtPSBzaXpl
b2YocGkpKSA+IGxlbikKIAkJCXJldHVybiAtRUlOVkFMOwogCiAJCW1lbWNweV9mcm9taW92ZWMo
KHZvaWQgKikmcGksIGl2LCBzaXplb2YocGkpKTsKCg==

------=____1098869528523_2uKa7Jow1---
