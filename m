Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSLLUBU>; Thu, 12 Dec 2002 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSLLUBU>; Thu, 12 Dec 2002 15:01:20 -0500
Received: from 24.213.60.124.up.mi.chartermi.net ([24.213.60.124]:3015 "EHLO
	front2.chartermi.net") by vger.kernel.org with ESMTP
	id <S265074AbSLLUBT>; Thu, 12 Dec 2002 15:01:19 -0500
Date: Thu, 12 Dec 2002 15:08:52 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: alan@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4-ac] Via 8233 Sound not working
Message-ID: <Pine.LNX.4.44.0212121459570.3368-300000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-500627633-1039723732=:3368"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-500627633-1039723732=:3368
Content-Type: TEXT/PLAIN; charset=US-ASCII

I needed this patch to compile so i just commented the
synchronize_irq bit out. I have included the patch and the error message.
This is a temp fix i don't know if this is correct or not.
Nathaniel
CC me at reddog83@chartermi.net as im not subscribed

--8323328-500627633-1039723732=:3368
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sound.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212121508520.3368@reddog.example.net>
Content-Description: Via 8233
Content-Disposition: attachment; filename="sound.diff"

ZGlmZiAtdXJOIGxpbnV4LWFjL2RyaXZlcnMvc291bmQvdmlhODJjeHh4X2F1
ZGlvLmMgbGludXgvZHJpdmVycy9zb3VuZC92aWE4MmN4eHhfYXVkaW8uYw0K
LS0tIGxpbnV4LWFjL2RyaXZlcnMvc291bmQvdmlhODJjeHh4X2F1ZGlvLmMJ
MjAwMi0xMi0xMiAwMzoyMTowNC4wMDAwMDAwMDAgLTA1MDANCisrKyBsaW51
eC9kcml2ZXJzL3NvdW5kL3ZpYTgyY3h4eF9hdWRpby5jCTIwMDItMTItMTIg
MTQ6NTQ6MzYuMDAwMDAwMDAwIC0wNTAwDQpAQCAtODg1LDcgKzg4NSw3IEBA
DQogDQogCXNwaW5fdW5sb2NrX2lycSAoJmNhcmQtPmxvY2spOw0KIA0KLQlz
eW5jaHJvbml6ZV9pcnEoY2FyZC0+cGRldi0+aXJxKTsNCisvKglzeW5jaHJv
bml6ZV9pcnEoY2FyZC0+cGRldi0+aXJxKTsgKi8NCiANCiAJRFBSSU5USyAo
IkVYSVRcbiIpOw0KIH0NCg==
--8323328-500627633-1039723732=:3368
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=tmp
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212121508521.3368@reddog.example.net>
Content-Description: Error Message from Compile
Content-Disposition: attachment; filename=tmp

dmlhODJjeHh4X2F1ZGlvLmM6ODg4OjQwOiBtYWNybyAic3luY2hyb25pemVf
aXJxIiBwYXNzZWQgMSBhcmd1bWVudHMsIGJ1dCB0YWtlcyBqdXN0IDANCnZp
YTgyY3h4eF9hdWRpby5jOiBJbiBmdW5jdGlvbiBgdmlhX2NoYW5fZnJlZSc6
DQp2aWE4MmN4eHhfYXVkaW8uYzo4ODg6IGBzeW5jaHJvbml6ZV9pcnEnIHVu
ZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0KdmlhODJj
eHh4X2F1ZGlvLmM6ODg4OiAoRWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
aXMgcmVwb3J0ZWQgb25seSBvbmNlDQp2aWE4MmN4eHhfYXVkaW8uYzo4ODg6
IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4uKQ0KbWFrZVsyXTog
KioqIFt2aWE4MmN4eHhfYXVkaW8ub10gRXJyb3IgMQ0KbWFrZVsxXTogKioq
IFtfbW9kc3ViZGlyX3NvdW5kXSBFcnJvciAyDQptYWtlOiAqKiogW19tb2Rf
ZHJpdmVyc10gRXJyb3IgMg0K
--8323328-500627633-1039723732=:3368--
