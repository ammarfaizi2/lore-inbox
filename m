Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSL1H4w>; Sat, 28 Dec 2002 02:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSL1H4w>; Sat, 28 Dec 2002 02:56:52 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:7300 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S265541AbSL1H4t>; Sat, 28 Dec 2002 02:56:49 -0500
Date: Fri, 27 Dec 2002 15:05:03 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: alan@redhat.com
cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.4-ac] VT8633 GART Support 
In-Reply-To: <Pine.LNX.4.44.0212200152220.1244-100000@reddog.example.net>
Message-ID: <Pine.LNX.4.44.0212231512260.1638-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-618221790-1040674600=:1638"
Content-ID: <Pine.LNX.4.44.0212231516570.1638@reddog.example.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-618221790-1040674600=:1638
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0212231516571.1638@reddog.example.net>

Alan, Marcello
This patch add's support for the Via VT8633 Agp Bridge.
It has been well tested and proves to have 3d support. I have played
DVD's and the 3d support is really good.
It applies to 2.4.20-ac2.
Please Apply
Nathaniel

--8323328-618221790-1040674600=:1638
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="agpgart.patch-ac"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212231516400.1638@reddog.example.net>
Content-Description: VT8633 AGP Support
Content-Disposition: ATTACHMENT; FILENAME="agpgart.patch-ac"

ZGlmZiAtdXJOIGxpbnV4LWFjL2RyaXZlcnMvY2hhci9kcm0vZHJtX2FncHN1
cHBvcnQuaH4gbGludXgtYWMvZHJpdmVycy9jaGFyL2RybS9kcm1fYWdwc3Vw
cG9ydC5oDQotLS0gbGludXgtYWMvZHJpdmVycy9jaGFyL2RybS9kcm1fYWdw
c3VwcG9ydC5ofgkyMDAyLTEyLTIwIDAyOjAxOjA2LjAwMDAwMDAwMCAtMDUw
MA0KKysrIGxpbnV4LWFjL2RyaXZlcnMvY2hhci9kcm0vZHJtX2FncHN1cHBv
cnQuaAkyMDAyLTEyLTIwIDAyOjE4OjU3LjAwMDAwMDAwMCAtMDUwMA0KQEAg
LTI4Myw2ICsyODMsOCBAQA0KIAkJCWJyZWFrOw0KIAkJY2FzZSBWSUFfQVBP
TExPX1BSTzogCWhlYWQtPmNoaXBzZXQgPSAiVklBIEFwb2xsbyBQcm8iOw0K
IAkJCWJyZWFrOw0KKwkJY2FzZSBWSUFfVlQ4NjMzOgloZWFkLT5jaGlwc2V0
ID0JIlZJQSBBcG9sbG8gUHJvMjY2IjsNCisJCQlicmVhazsNCiANCiAJCWNh
c2UgU0lTX0dFTkVSSUM6CWhlYWQtPmNoaXBzZXQgPSAiU2lTIjsgICAgICAg
ICAgIGJyZWFrOw0KIAkJY2FzZSBBTURfR0VORVJJQzoJaGVhZC0+Y2hpcHNl
dCA9ICJBTUQiOyAgICAgICAgICAgYnJlYWs7DQpkaWZmIC11ck4gbGludXgt
YWMvZHJpdmVycy9jaGFyL2RybS00LjAvYWdwc3VwcG9ydC5jfiBsaW51eC1h
di9kcml2ZXJzL2NoYXIvZHJtLTQuMC9hZ3BzdXBwb3J0LmMNCi0tLSBsaW51
eC1hYy9kcml2ZXJzL2NoYXIvZHJtLTQuMC9hZ3BzdXBwb3J0LmN+CTIwMDIt
MTItMjAgMDI6MDE6MDcuMDAwMDAwMDAwIC0wNTAwDQorKysgbGludXgtYWMv
ZHJpdmVycy9jaGFyL2RybS00LjAvYWdwc3VwcG9ydC5jCTIwMDItMTItMjAg
MDI6MTU6MDkuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMjgxLDYgKzI4MSw4IEBA
DQogDQogCQljYXNlIFZJQV9BUE9MTE9fUFJPOiAJaGVhZC0+Y2hpcHNldCA9
ICJWSUEgQXBvbGxvIFBybyI7DQogCQkJYnJlYWs7DQorCQljYXNlIFZJQV9W
VDg2MzM6CWhlYWQtPmNoaXBzZXQgPSAiVklBIEFwb2xsbyBQcm8yNjYiOw0K
KwkJCWJyZWFrOw0KIAkJY2FzZSBTSVNfR0VORVJJQzoJaGVhZC0+Y2hpcHNl
dCA9ICJTaVMiOyAgICAgICAgICAgYnJlYWs7DQogCQljYXNlIEFNRF9HRU5F
UklDOgloZWFkLT5jaGlwc2V0ID0gIkFNRCI7ICAgICAgICAgICBicmVhazsN
CiAJCWNhc2UgQU1EX0lST05HQVRFOgloZWFkLT5jaGlwc2V0ID0gIkFNRCBJ
cm9uZ2F0ZSI7ICBicmVhazsNCmRpZmYgLXVyTiBsaW51eC1hYy9kcml2ZXJz
L2NoYXIvYWdwL2FncGdhcnRfYmUuY34gbGludXgvZHJpdmVycy9jaGFyL2Fn
cC9hZ3BnYXJ0X2JlLmMNCi0tLSBsaW51eC1hYy9kcml2ZXJzL2NoYXIvYWdw
L2FncGdhcnRfYmUuY34JMjAwMi0xMi0yMCAwMjowMTowNS4wMDAwMDAwMDAg
LTA1MDANCisrKyBsaW51eC1hYy9kcml2ZXJzL2NoYXIvYWdwL2FncGdhcnRf
YmUuYwkyMDAyLTEyLTIwIDAyOjAzOjUxLjAwMDAwMDAwMCAtMDUwMA0KQEAg
LTQ3MzIsNiArNDczMiwxMiBAQA0KIAkJIlZpYSIsDQogCQkiQXBvbGxvIFBy
byBLVDQwMCIsDQogCQl2aWFfZ2VuZXJpY19zZXR1cCB9LA0KKwl7IFBDSV9E
RVZJQ0VfSURfVklBXzg2MzNfNSwNCisJCVBDSV9WRU5ET1JfSURfVklBLA0K
KwkJVklBX1ZUODYzMywNCisJCSJWaWEiLA0KKwkJIkFwb2xsbyBQcm8yNjYi
LA0KKwkJdmlhX2dlbmVyaWNfc2V0dXAgfSwNCiAJeyAwLA0KIAkJUENJX1ZF
TkRPUl9JRF9WSUEsDQogCQlWSUFfR0VORVJJQywNCmRpZmYgLXVyTiBsaW51
eC1hYy9pbmNsdWRlL2xpbnV4L2FncF9iYWNrZW5kLmh+IGxpbnV4LWFjL2lu
Y2x1ZGUvbGludXgvYWdwX2JhY2tlbmQuaA0KLS0tIGxpbnV4LWFjL2luY2x1
ZGUvbGludXgvYWdwX2JhY2tlbmQuaH4JMjAwMi0xMi0yMCAwMjowMToyMS4w
MDAwMDAwMDAgLTA1MDANCisrKyBsaW51eC1hYy9pbmNsdWRlL2xpbnV4L2Fn
cF9iYWNrZW5kLmgJMjAwMi0xMi0yMCAwMjowNTo1NS4wMDAwMDAwMDAgLTA1
MDANCkBAIC02MSw2ICs2MSw3IEBADQogCVZJQV9BUE9MTE9fS1gxMzMsDQog
CVZJQV9BUE9MTE9fS1QxMzMsDQogCVZJQV9BUE9MTE9fS1Q0MDAsDQorCVZJ
QV9WVDg2MzMsDQogCVNJU19HRU5FUklDLA0KIAlBTURfR0VORVJJQywNCiAJ
QU1EX0lST05HQVRFLA0K
--8323328-618221790-1040674600=:1638--
