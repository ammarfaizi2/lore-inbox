Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276452AbRJGROd>; Sun, 7 Oct 2001 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276461AbRJGROY>; Sun, 7 Oct 2001 13:14:24 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:54280 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276452AbRJGROE>;
	Sun, 7 Oct 2001 13:14:04 -0400
Message-ID: <3BC08DBE.5050305@si.rr.com>
Date: Sun, 07 Oct 2001 13:15:42 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.10-ac7: drivers/parport MODULE_LICENSE additions
Content-Type: multipart/mixed;
 boundary="------------070907020807070200010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907020807070200010101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached MODULE_LICENSE patches to modules within the 
drivers/parport directory. The patches are against 2.4.10-ac7 . Please 
review.
Regards,
Frank

--------------070907020807070200010101
Content-Type: text/plain;
 name="PARPORT1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PARPORT1"

--- drivers/parport/parport_amiga.c.old	Tue May 22 22:54:04 2001
+++ drivers/parport/parport_amiga.c	Sun Oct  7 12:46:53 2001
@@ -298,6 +298,7 @@
 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Parport Driver for Amiga builtin Port");
 MODULE_SUPPORTED_DEVICE("Amiga builtin Parallel Port");
+MODULE_LICENSE("GPL");
 
 module_init(parport_amiga_init)
 module_exit(parport_amiga_exit)

--------------070907020807070200010101
Content-Type: text/plain;
 name="PARPORT2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PARPORT2"

--- drivers/parport/parport_atari.c.old	Mon Nov 27 20:11:26 2000
+++ drivers/parport/parport_atari.c	Sun Oct  7 12:48:57 2001
@@ -249,6 +249,7 @@
 MODULE_AUTHOR("Andreas Schwab");
 MODULE_DESCRIPTION("Parport Driver for Atari builtin Port");
 MODULE_SUPPORTED_DEVICE("Atari builtin Parallel Port");
+MODULE_LICENSE("GPL");
 
 int
 init_module(void)

--------------070907020807070200010101
Content-Type: application/octet-stream;
 name="PARPORT3"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="PARPORT3"

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
--------------070907020807070200010101
Content-Type: application/octet-stream;
 name="PARPORT4"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="PARPORT4"

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==
--------------070907020807070200010101
Content-Type: application/octet-stream;
 name="PARPORT5"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="PARPORT5"

AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAIG9iai1tIDo9ICQoT19U
QVJHRVQpACAA
--------------070907020807070200010101--

