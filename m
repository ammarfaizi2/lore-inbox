Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265491AbRGHAzN>; Sat, 7 Jul 2001 20:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265494AbRGHAzC>; Sat, 7 Jul 2001 20:55:02 -0400
Received: from SMTP-OUT003.ONEMAIN.COM ([63.208.208.73]:606 "HELO
	smtp01.mail.onemain.com") by vger.kernel.org with SMTP
	id <S265491AbRGHAyo>; Sat, 7 Jul 2001 20:54:44 -0400
From: "Gerry Chu" <gerry@gerrychu.com>
To: <linux-kernel@vger.kernel.org>
Subject: modem problem solved
Date: Sat, 7 Jul 2001 17:54:06 -0700
Message-ID: <NCBBIACEOOOFMAJFGDBIAEBICJAA.gerry@gerrychu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solved with new ppp. Thanks, and sorry.
---------------------------------------
My modems (Courier 28.8 external, Actiontec PCI call waiting non-winmodem)
connect to the Internet fine with 2.4.0, and broke around 2.4.1. What
happens is they dial out, make those sounds, and just as they seem to be
about to connect, they disconnect. I'm pretty sure both kernels are
configured correctly. This still occurs with kernel 2.4.6.

