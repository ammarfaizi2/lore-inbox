Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSLGKeN>; Sat, 7 Dec 2002 05:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbSLGKeN>; Sat, 7 Dec 2002 05:34:13 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:2210 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S262207AbSLGKeM>; Sat, 7 Dec 2002 05:34:12 -0500
Date: Sat, 7 Dec 2002 05:41:54 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: reddog83@chartermi.net
cc: linux-kernel@vger.kernel.org, <davej@suse.de>
Subject: [PATCH 2.5.x] Via AGP Support
Message-ID: <Pine.LNX.4.44.0212070538190.1642-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-974259766-1039257714=:1642"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-974259766-1039257714=:1642
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch add's support for the Via 8633 AGP Card Slot.
This patch was diffed against current 2.5-BK tree.
Dave Jone's please take a look at it and see if it correct, if so please
add apply it to the Kernel tree.
The patch works on my Linux Box. And detects my AGP board.

PS Again thank you Dave.
CC me at reddog83@chartermi.net

--8323328-974259766-1039257714=:1642
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agp.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212070541540.1642@reddog.example.net>
Content-Description: Via AGP 8633 2.5
Content-Disposition: attachment; filename="agp.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNS9kcml2ZXJzL2NoYXIvYWdwL2FncC5jfiBs
aW51eC9kcml2ZXJzL2NoYXIvYWdwL2FncC5jDQotLS0gbGludXgtMi41L2Ry
aXZlcnMvY2hhci9hZ3AvYWdwLmN+CTIwMDItMTItMDUgMTM6NDQ6MTkuMDAw
MDAwMDAwIC0wNTAwDQorKysgbGludXgvZHJpdmVycy9jaGFyL2FncC9hZ3Au
YwkyMDAyLTEyLTA3IDA1OjM2OjEyLjAwMDAwMDAwMCAtMDUwMA0KQEAgLTEx
NjYsNiArMTE2NiwxNCBAQA0KIAkJLmNoaXBzZXRfc2V0dXAJPSB2aWFfZ2Vu
ZXJpY19zZXR1cA0KIAl9LA0KIAl7DQorCQkuZGV2aWNlX2lkCT0gUENJX0RF
VklDRV9JRF9WSUFfODYzM18wLA0KKwkJLnZlbmRvcl9pZAk9IFBDSV9WRU5E
T1JfSURfVklBLA0KKwkJLmNoaXBzZXQJPSBWSUFfR0VOUklDLA0KKwkJLnZl
bmRvcl9uYW1lCT0gIlZpYSIsDQorCQkuY2hpcHNldF9uYW1lCT0gIjg2MzMi
LA0KKwkJLmNoaXBzZXRfc2V0dXAJPSB2aWFfZ2VuZXJpY19zZXR1cA0KKwl9
LA0KKwl7DQogCQkuZGV2aWNlX2lkCT0gMCwNCiAJCS52ZW5kb3JfaWQJPSBQ
Q0lfVkVORE9SX0lEX1ZJQSwNCiAJCS5jaGlwc2V0CT0gVklBX0dFTkVSSUMs
DQo=
--8323328-974259766-1039257714=:1642--
