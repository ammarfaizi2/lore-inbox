Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSLGJbN>; Sat, 7 Dec 2002 04:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbSLGJbN>; Sat, 7 Dec 2002 04:31:13 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:6313 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S265700AbSLGJbM>; Sat, 7 Dec 2002 04:31:12 -0500
Date: Sat, 7 Dec 2002 04:38:56 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: reddog83@chartermi.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.20] Via 8233 Sound Support
Message-ID: <Pine.LNX.4.44.0212070433220.6330-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1694834921-1039253936=:6330"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1694834921-1039253936=:6330
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch adds support for the Via8233 Onboard Sound Card.
This patch applies to Linux Kernel 2.4.20 cleanly.
The only file this patch touch's is drivers/sound/via82cxxx_audio.c

Please apply to current Linux Kernel 2.4.x

Nathaniel

Please CC me as I'm not subscribed to the list
reddog83@chartermi.net

--8323328-1694834921-1039253936=:6330
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sound.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212070438560.6330@reddog.example.net>
Content-Description: Via 8233 Sound Support
Content-Disposition: attachment; filename="sound.diff"

ZGlmZiAtdXJOIGxpbnV4LXNvdW5kL2RyaXZlcnMvc291bmQvdmlhODJjeHh4
X2F1ZGlvLmMgbGludXgvZHJpdmVycy9zb3VuZC92aWE4MmN4eHhfYXVkaW8u
Yw0KLS0tIGxpbnV4LXNvdW5kL2RyaXZlcnMvc291bmQvdmlhODJjeHh4X2F1
ZGlvLmMJMjAwMi0wOC0wMiAyMDozOTo0NC4wMDAwMDAwMDAgLTA0MDANCisr
KyBsaW51eC9kcml2ZXJzL3NvdW5kL3ZpYTgyY3h4eF9hdWRpby5jCTIwMDIt
MTItMDcgMDQ6Mjg6MDQuMDAwMDAwMDAwIC0wNTAwDQpAQCAtNDAsNyArNDAs
NiBAQA0KICNpbmNsdWRlICJkZXZfdGFibGUuaCINCiAjaW5jbHVkZSAibXB1
NDAxLmgiDQogDQotDQogI3VuZGVmIFZJQV9ERUJVRwkvKiBkZWZpbmUgdG8g
ZW5hYmxlIGRlYnVnZ2luZyBvdXRwdXQgYW5kIGNoZWNrcyAqLw0KICNpZmRl
ZiBWSUFfREVCVUcNCiAvKiBub3RlOiBwcmludHMgZnVuY3Rpb24gbmFtZSBm
b3IgeW91ICovDQpAQCAtMzU0LDYgKzM1Myw4IEBADQogc3RhdGljIHN0cnVj
dCBwY2lfZGV2aWNlX2lkIHZpYV9wY2lfdGJsW10gX19pbml0ZGF0YSA9IHsN
CiAJeyBQQ0lfVkVORE9SX0lEX1ZJQSwgUENJX0RFVklDRV9JRF9WSUFfODJD
Njg2XzUsDQogCSAgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgfSwNCisJeyBQ
Q0lfVkVORE9SX0lEX1ZJQSwgUENJX0RFVklDRV9JRF9WSUFfODIzM181LA0K
KwkgIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIH0sDQogCXsgMCwgfQ0KIH07
DQogTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksdmlhX3BjaV90YmwpOw0K
--8323328-1694834921-1039253936=:6330--
