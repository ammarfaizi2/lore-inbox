Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131869AbQLNSs2>; Thu, 14 Dec 2000 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLNSsS>; Thu, 14 Dec 2000 13:48:18 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:65199 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131869AbQLNSr6>; Thu, 14 Dec 2000 13:47:58 -0500
Date: Thu, 14 Dec 2000 13:17:28 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: test13-pre1 Makefiles
Message-ID: <Pine.LNX.4.30.0012141315250.15676-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1585941084-976817848=:15676"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1585941084-976817848=:15676
Content-Type: TEXT/PLAIN; charset=US-ASCII

Small errors in two Makefiles

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================


---1463811839-1585941084-976817848=:15676
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="t13p1-Makefiles-1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0012141317280.15676@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="t13p1-Makefiles-1.diff"

ZGlmZiAtdXJ3IGxpbnV4LTIuNC4wLXRlc3QxMy5vcmlnL01ha2VmaWxlIGxp
bnV4L01ha2VmaWxlDQotLS0gbGludXgtMi40LjAtdGVzdDEzLm9yaWcvTWFr
ZWZpbGUJVGh1IERlYyAxNCAxMzoxMTozNCAyMDAwDQorKysgbGludXgvTWFr
ZWZpbGUJVGh1IERlYyAxNCAxMzoxMjo0NiAyMDAwDQpAQCAtMSw3ICsxLDcg
QEANCiBWRVJTSU9OID0gMg0KIFBBVENITEVWRUwgPSA0DQogU1VCTEVWRUwg
PSAwDQotRVhUUkFWRVJTSU9OID0gLXRlc3QxMg0KK0VYVFJBVkVSU0lPTiA9
IC10ZXN0MTMNCiANCiBLRVJORUxSRUxFQVNFPSQoVkVSU0lPTikuJChQQVRD
SExFVkVMKS4kKFNVQkxFVkVMKSQoRVhUUkFWRVJTSU9OKQ0KIA0KZGlmZiAt
dXJ3IGxpbnV4LTIuNC4wLXRlc3QxMy5vcmlnL2RyaXZlcnMvY2hhci9NYWtl
ZmlsZSBsaW51eC9kcml2ZXJzL2NoYXIvTWFrZWZpbGUNCi0tLSBsaW51eC0y
LjQuMC10ZXN0MTMub3JpZy9kcml2ZXJzL2NoYXIvTWFrZWZpbGUJVGh1IERl
YyAxNCAxMjoyODoyMiAyMDAwDQorKysgbGludXgvZHJpdmVycy9jaGFyL01h
a2VmaWxlCVRodSBEZWMgMTQgMTM6MTM6MjEgMjAwMA0KQEAgLTE1NSw3ICsx
NTUsNyBAQA0KIHN1YmRpci0kKENPTkZJR19GVEFQRSkgKz0gZnRhcGUNCiBz
dWJkaXItJChDT05GSUdfRFJNKSArPSBkcm0NCiBzdWJkaXItJChDT05GSUdf
UENNQ0lBKSArPSBwY21jaWENCi1zdWJkaXItJChDT05GSUdfYWdwKSArPSBh
Z3ANCitzdWJkaXItJChDT05GSUdfQUdQKSArPSBhZ3ANCiANCiBpZmVxICgk
KENPTkZJR19GVEFQRSkseSkNCiBvYmoteSAgICAgICArPSBmdGFwZS9mdGFw
ZS5vDQo=
---1463811839-1585941084-976817848=:15676--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
