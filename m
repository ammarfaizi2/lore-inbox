Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKFF0T>; Tue, 6 Nov 2001 00:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKFFZq>; Tue, 6 Nov 2001 00:25:46 -0500
Received: from viper.haque.net ([66.88.179.82]:24960 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S277143AbRKFFZQ>;
	Tue, 6 Nov 2001 00:25:16 -0500
Date: Tue, 6 Nov 2001 00:25:16 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] remove deactivate_page call in loop.c
Message-ID: <Pine.LNX.4.33.0111060023180.1597-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1480741555-122262502-1005024316=:1597"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1480741555-122262502-1005024316=:1597
Content-Type: TEXT/PLAIN; charset=US-ASCII

No problems so far.
Since lots of people are asking about this....

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://www.themes.org/
                                               batmanppc@themes.org
=====================================================================

--1480741555-122262502-1005024316=:1597
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="loop-deactivate_page.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0111060025160.1597@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="loop-deactivate_page.diff"

LS0tIGxpbnV4L2RyaXZlcnMvYmxvY2svbG9vcC5jLm9yaWcJTW9uIE5vdiAg
NSAyMzowMToxMCAyMDAxDQorKysgbGludXgvZHJpdmVycy9ibG9jay9sb29w
LmMJVHVlIE5vdiAgNiAwMDoyMTo1OSAyMDAxDQpAQCAtMjE4LDE0ICsyMTgs
MTIgQEANCiAJCWluZGV4Kys7DQogCQlwb3MgKz0gc2l6ZTsNCiAJCVVubG9j
a1BhZ2UocGFnZSk7DQotCQlkZWFjdGl2YXRlX3BhZ2UocGFnZSk7DQogCQlw
YWdlX2NhY2hlX3JlbGVhc2UocGFnZSk7DQogCX0NCiAJcmV0dXJuIDA7DQog
DQogdW5sb2NrOg0KIAlVbmxvY2tQYWdlKHBhZ2UpOw0KLQlkZWFjdGl2YXRl
X3BhZ2UocGFnZSk7DQogCXBhZ2VfY2FjaGVfcmVsZWFzZShwYWdlKTsNCiBm
YWlsOg0KIAlyZXR1cm4gLTE7DQo=
--1480741555-122262502-1005024316=:1597--
