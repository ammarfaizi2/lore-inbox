Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbTDRPeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbTDRPeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:34:14 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62896 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263104AbTDRPeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:34:13 -0400
Date: Fri, 18 Apr 2003 11:46:06 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: hch@lst.de
cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] devfs compile fix for 2.5.67-bk9
Message-ID: <Pine.LNX.4.55.0304181142510.24360@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1877034064-1050680766=:24360"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1877034064-1050680766=:24360
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello!

Attached patch fixes 2 trivial compile errors in fs/devfs/base.c in Linux
2.5.67-bk9.

-- 
Regards,
Pavel Roskin
--8323328-1877034064-1050680766=:24360
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="devfs.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.55.0304181146060.24360@marabou.research.att.com>
Content-Description: 
Content-Disposition: attachment; filename="devfs.diff"

LS0tIGxpbnV4Lm9yaWcvZnMvZGV2ZnMvYmFzZS5jDQorKysgbGludXgvZnMv
ZGV2ZnMvYmFzZS5jDQpAQCAtMTQyMyw3ICsxNDIzLDcgQEAgc3RhdGljIGlu
dCBkZXZmc2Rfbm90aWZ5X2RlIChzdHJ1Y3QgZGV2Zg0KIHN0YXRpYyB2b2lk
IGRldmZzZF9ub3RpZnkgKHN0cnVjdCBkZXZmc19lbnRyeSAqZGUsdW5zaWdu
ZWQgc2hvcnQgdHlwZSkNCiB7DQogCWRldmZzZF9ub3RpZnlfZGUoZGUsIHR5
cGUsIGRlLT5tb2RlLCBjdXJyZW50LT5ldWlkLA0KLQkJCSBjdXJyZW50LT5l
Z2lkLCAmZnNfaW5mbywgMCk7DQorCQkJIGN1cnJlbnQtPmVnaWQsICZmc19p
bmZvKTsNCiB9IA0KIA0KIA0KQEAgLTE0NTcsNyArMTQ1Nyw3IEBAIGRldmZz
X2hhbmRsZV90IGRldmZzX3JlZ2lzdGVyIChkZXZmc19oYW4NCiAgICAgc3Ry
dWN0IGRldmZzX2VudHJ5ICpkZTsNCiANCiAgICAgaWYgKGZsYWdzKQ0KLQlw
cmludGsoS0VSTl9FUlIgIiVzIGNhbGxlZCB3aXRoIGZsYWdzICE9IDAsIHBs
ZWFzZSBmaXghXG4iKTsNCisJcHJpbnRrKEtFUk5fRVJSICIlcyBjYWxsZWQg
d2l0aCBmbGFncyAhPSAwLCBwbGVhc2UgZml4IVxuIiwgbmFtZSk7DQogDQog
ICAgIGlmIChuYW1lID09IE5VTEwpDQogICAgIHsNCg==

--8323328-1877034064-1050680766=:24360--
