Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSLGJKa>; Sat, 7 Dec 2002 04:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSLGJKa>; Sat, 7 Dec 2002 04:10:30 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:41860 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S261644AbSLGJK3>; Sat, 7 Dec 2002 04:10:29 -0500
Date: Sat, 7 Dec 2002 04:18:12 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: reddog83@chartermi.net
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.20] Via AGP 8633 
Message-ID: <Pine.LNX.4.44.0212070413510.5667-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1426775555-1039252692=:5667"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1426775555-1039252692=:5667
Content-Type: TEXT/PLAIN; charset=US-ASCII

This patch add's support for the Via 8633 AGP Card it is diffed against
Linux Kernel-2.4.20 and most likely applies to current 2.5.x series
kernel.
Please Apply.

Nathaniel

PS. Thank you Dave for pointing me in the right direction, it just alittle
common sense and it works.

Please CC me as I'm not subsribed to the list
reddog83@chartermi.net

--8323328-1426775555-1039252692=:5667
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agpgart.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212070418120.5667@reddog.example.net>
Content-Description: Via 8633 AGP
Content-Disposition: attachment; filename="agpgart.diff"

ZGlmZiAtdXJOIGxpbnV4LWFncC9kcml2ZXJzL2NoYXIvYWdwL2FncGdhcnRf
YmUuY34gbGludXgvZHJpdmVycy9jaGFyL2FncC9hZ3BnYXJ0X2JlLmMNCi0t
LSBsaW51eC1hZ3AvZHJpdmVycy9jaGFyL2FncC9hZ3BnYXJ0X2JlLmMJMjAw
Mi0xMi0wMiAxOToyMDoyMi4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC9k
cml2ZXJzL2NoYXIvYWdwL2FncGdhcnRfYmUuYwkyMDAyLTEyLTA3IDA0OjA5
OjU5LjAwMDAwMDAwMCAtMDUwMA0KQEAgLTQ3MTQsNiArNDcxNCwxMiBAQA0K
IAkJIlZpYSIsDQogCQkiQXBvbGxvIFBybyBLVDI2NiIsDQogCQl2aWFfZ2Vu
ZXJpY19zZXR1cCB9LA0KKwl7IFBDSV9ERVZJQ0VfSURfVklBXzg2MzNfMCwN
CisJCVBDSV9WRU5ET1JfSURfVklBLA0KKwkJVklBX0dFTkVSSUMsDQorCQki
VmlhIiwNCisJCSI4NjMzIiwNCisJCXZpYV9nZW5lcmljX3NldHVwIH0sDQog
CXsgMCwNCiAJCVBDSV9WRU5ET1JfSURfVklBLA0KIAkJVklBX0dFTkVSSUMs
DQo=
--8323328-1426775555-1039252692=:5667--
