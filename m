Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDJQFz>; Tue, 10 Apr 2001 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbRDJQFp>; Tue, 10 Apr 2001 12:05:45 -0400
Received: from www.thebucket.org ([216.63.180.35]:24851 "EHLO www")
	by vger.kernel.org with ESMTP id <S132392AbRDJQFj>;
	Tue, 10 Apr 2001 12:05:39 -0400
Date: Tue, 10 Apr 2001 11:43:13 -0500 (CDT)
From: Bart Dorsey <echo@thebucket.org>
To: linux-kernel@vger.kernel.org
Subject: Patch to abyss.c against 2.4.2-ac28
Message-ID: <Pine.LNX.4.21.0104101140410.25307-200000@www>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-76311105-986920993=:25307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-76311105-986920993=:25307
Content-Type: TEXT/PLAIN; charset=US-ASCII

This is my first time sending in a patch to the kernel. 

This is a one line fix to the abyss tokenring driver in 2.4.2-ac28

I got this fix from the driver maintainer who said 

"I guess I really should send this in to Linus"

I'm just going to go ahead and jump the gun and submit it ;)



--8323328-76311105-986920993=:25307
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch-abyss-2.4.2-ac28.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0104101143130.25307@www>
Content-Description: 
Content-Disposition: attachment; filename="patch-abyss-2.4.2-ac28.diff"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L3Rva2VucmluZy9hYnlzcy5jLm9sZAlG
cmkgRmViIDE2IDE4OjAyOjM2IDIwMDENCisrKyBsaW51eC9kcml2ZXJzL25l
dC90b2tlbnJpbmcvYWJ5c3MuYwlXZWQgTWFyIDE0IDE1OjIwOjAwIDIwMDEN
CkBAIC0xMzcsNyArMTM3LDcgQEANCiAJICovDQogCWRldi0+YmFzZV9hZGRy
ICs9IDB4MTA7DQogCQkNCi0JcmV0ID0gdG1zZGV2X2luaXQoZGV2LDAscGRl
dik7DQorCXJldCA9IHRtc2Rldl9pbml0KGRldiwweGZmZmZmZmZmLHBkZXYp
Ow0KIAkvKiBYWFg6IHNob3VsZCBiZSB0aGUgbWF4IFBDSTMyIERNQSBtYXgg
Ki8NCiAJaWYgKHJldCkgew0KIAkJcHJpbnRrKCIlczogdW5hYmxlIHRvIGdl
dCBtZW1vcnkgZm9yIGRldi0+cHJpdi5cbiIsIA0K
--8323328-76311105-986920993=:25307--
