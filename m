Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312071AbSCQQoA>; Sun, 17 Mar 2002 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312072AbSCQQnk>; Sun, 17 Mar 2002 11:43:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52754 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312071AbSCQQnd>; Sun, 17 Mar 2002 11:43:33 -0500
Subject: Re: [PATCH] Natsemi Geode GXn PM support and extended MMX
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Sun, 17 Mar 2002 16:59:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel),
        davej@suse.de (Dave Jones)
In-Reply-To: <Pine.LNX.4.44.0203170926300.6387-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Mar 17, 2002 09:27:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16me0C-0002u1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > is doing the right thing on every box I have ever seen. The extended MMX
> > one looks right, providing we don't turn it on for any CPU lacking it
> 
> Hmm thanks for the warning, i wonder if the BIOS enables most of the APM 
> features of the CPU as well.

The ones I've looked at do - remember any Geode BIOS is customised for that
CPU alone and already has either VSA1 or VSA2 built into it - its not like
a socket 7 board where many machines have CPU's newer than the bios

