Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313865AbSDUV3B>; Sun, 21 Apr 2002 17:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSDUV3A>; Sun, 21 Apr 2002 17:29:00 -0400
Received: from mail.uklinux.net ([80.84.72.21]:63238 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S313865AbSDUV27>;
	Sun, 21 Apr 2002 17:28:59 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: "Sean Rima" <fido@tcob1.net>
To: linux-kernel@vger.kernel.org
Subject: 3c509 problem in 2.4.3
Message-ID: <MSGID_2=3a263=2f950_14789c87@fidonet.org>
Date: Sunday, 21 Apr 2002 21:51:04 +0000
X-Mailer: Internet Rex gateway (2.67 beta 1a)
X-Fido-From: Sean Rima, 2:263/950
X-Fido-To: All
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *16zOpY-0001is-00*5LG4QE41Mlg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally to: All

I use a 3Com 3c509 which I have used okay under 2.2.20. However when I compiled abd installed 2.4.18, the card was no longer available. The card was installed via the 3Com utilty disk, and auto set, 
which gave it settings of io 0x210 and IRQ 10. To use under 2.4.18 I have to boot dos, change it to io 0x200 and irq 7.

Okay, this is not major but I have heard of others having problems with the 3c509 driver.

Sean

--
 Message from TCOB1, Ireland's best BBS

<-> Gateway Information.
This message originated from a Fidonet System (http://www.fidonet.org)
and was gated at TCOB1 (http://www.tcob1.net)
Please do not respond direct to this message but via the list


