Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSDNHf0>; Sun, 14 Apr 2002 03:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311739AbSDNHf0>; Sun, 14 Apr 2002 03:35:26 -0400
Received: from dsl092-148-080.wdc1.dsl.speakeasy.net ([66.92.148.80]:53381
	"EHLO tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S310835AbSDNHfY>; Sun, 14 Apr 2002 03:35:24 -0400
Date: Sun, 14 Apr 2002 03:35:17 -0400 (EDT)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: maxwell@tyan.doghouse.com
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
cc: linux-kernel@vger.kernel.org, <linux-smp@vger.kernel.org>
Subject: Re: SMP motherboards (760 MPX chipset) and SMP howto
In-Reply-To: <7wsn6mx6up.fsf@frog.soft.sdesigns.com>
Message-ID: <Pine.LNX.4.44.0204140323100.1972-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002, Emmanuel Michon wrote:

> I'm sorry to write here for a problem only about SMP: there used to be
> a linux-smp mailing list but it seems it's not active anymore.

The linux-smp list was active when SMP issues needed discussion because the 
code and the hardware was less mature.  These days both code and hardware have 
matured and most notable issues effecting SMP are discussed here.

> It seems AMD Athlon SMP spec is compatible with Intel's one; can
> someone report that the A7M266-D motherboard with the 760 MPX chipset
> is running fine linux SMP?

I have a Tyan S2466N which is the 760 MPX chipset.  Configuration is:

Tyan 2466N MPX Chipset
Two Athlon MP 1800+ (1530Mhz chips, matched steppings)
Matrox G450 AGP video
Opti USB 1.1 PCI card
Promise Ultra66 EIDE card
Ensoniq AudioPCI (ES1370 chip) sound card
Two Crucial Technologies PC2100 ECC 512M DIMMs (registered)
IBM DeskStar 22GXP EIDE drive
Antec Performance Plus 880 case (430W power supply)
EIDE cdrom
3.5" Floppy drive

I've been using this for about 10 days now with no significant problems--all 
issues have been related to this hardware/kernel/OS configuration and have 
been worked out.  Performance is very good compared to the dual Pentium 2 - 
400 Mhz processor system this new box is replacing.

I recommend using Athlon MP processors, retail box, not Athlon XP and not OEM.  
It's worth a small amount more money to know that you have quality equipment
and that any issues that do develop will not be because you bought poor
quality hardware.  The retail processors have a 3 year warranty on them, and I 
think this is important with today's hot-running, sensitive processors.  I've 
already had one AMD Athlon 1000 Thunderbird replaced under warranty and was 
very happy with AMD's handling of it.

> SMP gurus must have a discussion room more specific than linux-kernel
> mailing list at some hidden place!

If you have good topics to discuss, please post on here or linux-smp list.  
People are watching in both places.

-- ----------------------------------------------------------------------------
Maxwell Spangler                                                 Save Futurama!
Program Writer                                               Sign the petition!
Greenbelt, Maryland, U.S.A.                         http://www.gotfuturama.com/
Washington D.C. Metropolitan Area 

