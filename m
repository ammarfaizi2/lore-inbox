Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264101AbRFNWCD>; Thu, 14 Jun 2001 18:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264112AbRFNWBw>; Thu, 14 Jun 2001 18:01:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59919 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264101AbRFNWBn>; Thu, 14 Jun 2001 18:01:43 -0400
Subject: Re: Gigabit Intel NIC? - Intel Gigabit Ethernet Pro/1000T
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Thu, 14 Jun 2001 22:58:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rhw@MemAlpha.CX (Riley Williams),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        spstarr@sh0n.net (Shawn Starr), linux-kernel@vger.kernel.org
In-Reply-To: <20010614145221.H17427@one-eyed-alien.net> from "Matthew Dharm" at Jun 14, 2001 02:52:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Af89-0005VK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know, jumping in at this late-stage is bad form... but if we're talking
> about the Intel 82543GC Gigabit MAC, why doesn't someone just use the
> FreeBSD if_wx.c driver as a starting point?

Intel have released a BSD like licensed gig-E driver for Linux. It needs a
serious cleanup but the hardware interface is very very clean so that is a
doable job. There are some patent related licensing issues but the discussion
on resolving that and getting them into the kernel does look promising
