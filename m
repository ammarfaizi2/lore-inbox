Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282574AbRKZV0L>; Mon, 26 Nov 2001 16:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282572AbRKZV0B>; Mon, 26 Nov 2001 16:26:01 -0500
Received: from fepB.post.tele.dk ([195.41.46.145]:33533 "EHLO
	fepB.post.tele.dk") by vger.kernel.org with ESMTP
	id <S282569AbRKZVZs>; Mon, 26 Nov 2001 16:25:48 -0500
Message-ID: <004d01c17709$0737e840$0b00a8c0@runner>
From: "Rune" <runner@mail.tele.dk>
To: <linux-kernel@vger.kernel.org>
Subject: "SIS-360" - "Olicom CrossFire 8720 switch" problem on kernel 2.4.4+
Date: Mon, 26 Nov 2001 22:01:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there I've got a problem I'd like to share with:

When my SIS-360 derived labtop to my Crossfire 8720 switch the
auto-negotiation will fail (timeout) under the following conditions:
                - using the drivers from Kernel 2.4.4+  (I have tried
2.4.14)
                - auto-negotiation is enabled ;)
                - using DHCP
                - netcard-revision: 0x80 (haven't tried others)
                -the netcard must be directly connected to the switch

all other configurations works, and everything works on other switches...

This switch has also been sold in the US, but under another name, but
its still called CrossFire 8720.

I have talked to Hui-Fen (SIS), who has made the driver, but he can't
reproduce the conditions because SIS don't own such a switch.


Since I'm not capable of fixing it myself, I thought I'd try my luck here:

Are there anyone here capable of "fixing" the driver who owns a
SIS360-chipset and Olicom CrossFire 8720 or can get their hands them.
Or just reproduce it..

Rune Petersen


