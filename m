Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264017AbRFMPnE>; Wed, 13 Jun 2001 11:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbRFMPmy>; Wed, 13 Jun 2001 11:42:54 -0400
Received: from [194.102.102.3] ([194.102.102.3]:13576 "HELO ns1.Aniela.EU.ORG")
	by vger.kernel.org with SMTP id <S264017AbRFMPmt>;
	Wed, 13 Jun 2001 11:42:49 -0400
Date: Wed, 13 Jun 2001 18:42:35 +0300 (EEST)
From: "L. K." <lk@Aniela.EU.ORG>
To: linux-kernel@vger.kernel.org
Subject: 3C905B -- EEPROM (i blive so) problem
Message-ID: <Pine.LNX.4.21.0106131838110.30298-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a 3COM 3C905B ethernet card that has been hit by a power outage for
aprox. 0.5 sec.  Now, the kernel does not recongnize the card
anymore. When I do lspci, I see 3COM Ethernet controller, type unknown
0xffffff (rev 3x). The bios reports the card as an ethernet card at system
boot-up. I run the diagnostic program for 3com cards from Donald Becker
and all the card registers are 0000 and FFFF. I do belive something
happened to the eeprom of the card. I would like to know if I can
overwrite-it with a new one so that I can make my ethernet card work
again.


Thank you,

Eugen

