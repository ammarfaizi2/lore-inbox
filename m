Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUE1KAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUE1KAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 06:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUE1KAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 06:00:24 -0400
Received: from berlin163.server4free.de ([217.172.180.163]:4046 "EHLO
	berlin163.server4free.de") by vger.kernel.org with ESMTP
	id S265878AbUE1KAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 06:00:19 -0400
Date: Fri, 28 May 2004 12:00:04 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] I2C_ISA needs ISA - Kconfig
Message-ID: <Pine.LNX.4.58.0405281155260.31846@berlin163.server4free.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1395022924-437220494-1085738404=:31846"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1395022924-437220494-1085738404=:31846
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Hello,


Small patch. You should select ISA for i2c-isa. Right?


Thomas


-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
---1395022924-437220494-1085738404=:31846
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="i2c-isa-kconfig.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0405281200040.31846@berlin163.server4free.de>
Content-Description: 
Content-Disposition: attachment; filename="i2c-isa-kconfig.patch"

ZGlmZiAtTnVyIGxpbnV4LTIuNi42L2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29u
ZmlnIGxpbnV4LTIuNi42LmVkaXRlZC9kcml2ZXJzL2kyYy9idXNzZXMvS2Nv
bmZpZw0KLS0tIGxpbnV4LTIuNi42L2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29u
ZmlnCTIwMDQtMDUtMjggMTE6MTk6NDcuMDAwMDAwMDAwICswMjAwDQorKysg
bGludXgtMi42LjYuZWRpdGVkL2RyaXZlcnMvaTJjL2J1c3Nlcy9LY29uZmln
CTIwMDQtMDUtMjggMTE6MjA6MDYuMDAwMDAwMDAwICswMjAwDQpAQCAtMTI3
LDcgKzEyNyw3IEBADQogDQogY29uZmlnIEkyQ19JU0ENCiAJdHJpc3RhdGUg
IklTQSBCdXMgc3VwcG9ydCINCi0JZGVwZW5kcyBvbiBJMkMgJiYgRVhQRVJJ
TUVOVEFMDQorCWRlcGVuZHMgb24gSTJDICYmIElTQSAmJiBFWFBFUklNRU5U
QUwNCiAJaGVscA0KIAkgIElmIHlvdSBzYXkgeWVzIHRvIHRoaXMgb3B0aW9u
LCBzdXBwb3J0IHdpbGwgYmUgaW5jbHVkZWQgZm9yIGkyYw0KIAkgIGludGVy
ZmFjZXMgdGhhdCBhcmUgb24gdGhlIElTQSBidXMuDQo=

---1395022924-437220494-1085738404=:31846--
