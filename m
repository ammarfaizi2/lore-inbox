Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292234AbSBTUOv>; Wed, 20 Feb 2002 15:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSBTUOk>; Wed, 20 Feb 2002 15:14:40 -0500
Received: from web10508.mail.yahoo.com ([216.136.130.158]:53257 "HELO
	web10508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292234AbSBTUOc>; Wed, 20 Feb 2002 15:14:32 -0500
Message-ID: <20020220201431.47018.qmail@web10508.mail.yahoo.com>
Date: Wed, 20 Feb 2002 12:14:31 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: Re: Dlink DSL PCI Card
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Hatfield <lkml@secureone.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16dcnl-0004Wd-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The same reasoning goes for another reason. Some of
> the newest DSL PCI cards are in many respects
> winmodems at multimegabit speed levels, burning 
> huge chunks of CPU on a pentium III processor even.

3061 is a true winmodem whose PCI activity has been
unofficially reportedly known to have a burst-rate of
a staggering 23Mbps.  (33-23=) 11 Mhz PCI bus anyone?

On other hand, Efficient SpeedStream 3060 is a
bon-fide true DSL PCI adapter card with
downstream-only PCI accesses where its microcode is
loaded into its adapter, but again, its microcode is
NDA'd and more expensive than 3061.

Neither (and all other DSL and Winmodem adapter cards)
are going to make a viable candidate for (if any)
Linux-adapter-of-the-year award EVER ... until we
successfully and collectively apply Linux-PR
guidelines of tactful campaigning the chipset
manufacturers into releasing their datasheets (oh, yes
Alan): and demand a downstream-PCI-only adapter.

Chicken and the egg dilemna for both sides.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - Coverage of the 2002 Olympic Games
http://sports.yahoo.com
