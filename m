Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBMMJ7>; Tue, 13 Feb 2001 07:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129463AbRBMMJs>; Tue, 13 Feb 2001 07:09:48 -0500
Received: from web3502.mail.yahoo.com ([204.71.203.69]:10257 "HELO
	web3502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129242AbRBMMJk>; Tue, 13 Feb 2001 07:09:40 -0500
Message-ID: <20010213120932.8110.qmail@web3502.mail.yahoo.com>
Date: Tue, 13 Feb 2001 12:09:32 +0000 (GMT)
From: Michèl Alexandre Salim 
	<salimma1@yahoo.co.uk>
Subject: PCI GART (?)
To: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This might not be the proper place to ask - my
apologies - but since it pertains to the Sony
Picturebook (C1VE - Crusoe) that people have been
discussing on this list anyway, I hope people don't
mind too much :)

I have RTFM but on the matter of enabling DRI for the
ATI Mobility video chipset, which on that notebook is
a PCI model, there is practically nil information. The
DRI website mentions using PCI GART, but there is no
option for that in the kernel. How do I enable this?

Currently running the XFree 4.0.2 from RH 7.0.90 (7.1
beta, Fisher) on top of my RH 7 + Ximian system and
when using aviplay it doesn't use any acceleration
features at all, consequently choppy display. The same
file plays much better in Windows.

Xdpyinfo shows that Xvideo and Xrender are both
loaded, so I presume they *should* work.

Thanks in advance,

Michel Salim

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
