Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129577AbRBMNCi>; Tue, 13 Feb 2001 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130172AbRBMNC2>; Tue, 13 Feb 2001 08:02:28 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129577AbRBMNCL>; Tue, 13 Feb 2001 08:02:11 -0500
Subject: Re: PCI GART (?)
To: salimma1@yahoo.co.uk (Michèl Alexandre Salim)
Date: Tue, 13 Feb 2001 13:02:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <20010213120932.8110.qmail@web3502.mail.yahoo.com> from "Michèl Alexandre Salim" at Feb 13, 2001 12:09:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Sf6W-0001iU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have RTFM but on the matter of enabling DRI for the
> ATI Mobility video chipset, which on that notebook is
> a PCI model, there is practically nil information. The
> DRI website mentions using PCI GART, but there is no
> option for that in the kernel. How do I enable this?

You need to get XFree86 CVS and really the right place to ask
is the XFree86 folks. The standard kernel doesnt include pcigart

> Xdpyinfo shows that Xvideo and Xrender are both
> loaded, so I presume they *should* work.

Could be your aviplay doesnt support it.
