Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261953AbSIYKIE>; Wed, 25 Sep 2002 06:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261954AbSIYKID>; Wed, 25 Sep 2002 06:08:03 -0400
Received: from mailgate2.uea.ac.uk ([139.222.230.101]:527 "EHLO
	mailgate2.uea.ac.uk") by vger.kernel.org with ESMTP
	id <S261953AbSIYKID>; Wed, 25 Sep 2002 06:08:03 -0400
Date: Wed, 25 Sep 2002 11:13:10 +0100 (BST)
From: wbh <W.B.Hill@uea.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Y-251U drive adapter/USB
Message-ID: <Pine.OSF.4.05.10209251103370.16852-200000@cpca7.uea.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-653472587-1032948790=:16852"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-653472587-1032948790=:16852
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi. I got a Y-251U USB drive enclosure this morning, as at
http://www.cable-world.com/newproduct/USB10HDD.htm
Doesn't appear to work with Linux by default, but it's based on the
GL241USB chip and a Compact Flash reader based on that works,
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.2/1445.html
So, altering it slightly I get the attached patch, which works for me.


--0-653472587-1032948790=:16852
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4.18-Y-251U.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.OSF.4.05.10209251113100.16852@cpca7.uea.ac.uk>
Content-Description: Patch for Y-251U USB drive enclosure.
Content-Disposition: attachment; filename="linux-2.4.18-Y-251U.patch"

ZGlmZiAtdXJOIGxpbnV4LTIuNC4xOC1wbGFpbi9kcml2ZXJzL3VzYi9zdG9y
YWdlL3VudXN1YWxfZGV2cy5oIGxpbnV4LTIuNC4xOC1wYXRjaC9kcml2ZXJz
L3VzYi9zdG9yYWdlL3VudXN1YWxfZGV2cy5oDQotLS0gbGludXgtMi40LjE4
LXBsYWluL2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF9kZXZzLmgJTW9u
IEZlYiAyNSAyMDozODowNyAyMDAyDQorKysgbGludXgtMi40LjE4LXBhdGNo
L2RyaXZlcnMvdXNiL3N0b3JhZ2UvdW51c3VhbF9kZXZzLmgJTW9uIEFwciAy
MiAxNzozNzozNSAyMDAyDQpAQCAtMjkyLDYgKzI5MiwxMiBAQA0KIAkJVVNf
RkxfTU9ERV9YTEFURSB8IFVTX0ZMX1NUQVJUX1NUT1AgKSwNCiAjZW5kaWYN
CiANCitVTlVTVUFMX0RFViggIDB4MDVlMywgMHgwNzAyLCAweDAwMDAsIDB4
OTk5OSwNCisJCSJTLlkuQy5ULiIsDQorCQkiR0w2NDEgVVNCIGRyaXZlIiwN
CisJCVVTX1NDX1NDU0ksIFVTX1BSX0JVTEssIE5VTEwsDQorCQlVU19GTF9G
SVhfSU5RVUlSWSB8IFVTX0ZMX1NUQVJUX1NUT1ApLA0KKw0KIFVOVVNVQUxf
REVWKCAgMHgwNjQ0LCAweDAwMDAsIDB4MDEwMCwgMHgwMTAwLCANCiAJCSJU
RUFDIiwNCiAJCSJGbG9wcHkgRHJpdmUiLA0KDQo=
--0-653472587-1032948790=:16852--
