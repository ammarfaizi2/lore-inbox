Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136552AbRD3Xta>; Mon, 30 Apr 2001 19:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136549AbRD3XtU>; Mon, 30 Apr 2001 19:49:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5638 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136552AbRD3XtD>; Mon, 30 Apr 2001 19:49:03 -0400
Subject: Re: Oopses under 2.4.4pre8 with Tbird 1.2GHz/Epox 8kta3
To: gold@shell.aros.net (Lawrence Gold)
Date: Tue, 1 May 2001 00:53:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010430114718.A28728@shell.aros.net> from "Lawrence Gold" at Apr 30, 2001 11:47:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uNTX-0000hd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This problem is only seen on VIA chipsets so far. Never on AMD ones.
> > This leads me to the current tentative diagnosis of 'VIA chipset bug'
> 
> Thanks, at least that clears up some of the mystery.  Do you foresee any
> problems with running on this setup using a kernel compiled for Athlon but
> with the 3DNOW line commented out in arch/i386/config.in?  Should I go one

The VIA PCI bugs should be properly worked around in 2.4.3+ so it should be
ok

> 

