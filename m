Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280785AbRKOIlM>; Thu, 15 Nov 2001 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKOIlC>; Thu, 15 Nov 2001 03:41:02 -0500
Received: from devour.demon.co.uk ([158.152.76.196]:4360 "HELO
	starbug.devour.org") by vger.kernel.org with SMTP
	id <S280784AbRKOIku>; Thu, 15 Nov 2001 03:40:50 -0500
Message-ID: <001e01c16db1$3685ec70$0f00a8c0@seduction>
From: "Chris King" <chris@admins.devour.org>
To: <linux-kernel@vger.kernel.org>
Subject: Fw: Linux on old i486 board
Date: Thu, 15 Nov 2001 08:39:27 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing rather strange problems with the 2.2 kernel.
Basically, on this system, (which has an i486 w/ pentium overdrive
processor - although this is probably irrelevent), pppd under 2.0 and 2.4
works fine. However, on 2.2, during disk access or general strain on the ISA
bus, ppp drops packets - either as errors or frame errors. Also, I
occaisonally see VJ decompression errors in the logfiles.
The distribution I'm using is Slackware 8.0, which utilises pppd 2.4.1.

I am unsure what other information to supply, although the following could
be relevant;

bootlog, (under 2.4.14)
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14


If anyone could help in any way, it would be greatly appreciated.


