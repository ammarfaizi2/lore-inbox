Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSKIJXx>; Sat, 9 Nov 2002 04:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSKIJXx>; Sat, 9 Nov 2002 04:23:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38391 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264673AbSKIJXw>; Sat, 9 Nov 2002 04:23:52 -0500
Date: Sat, 9 Nov 2002 10:30:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Daniel Egger <degger@fhm.edu>, linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Conflict
Message-ID: <20021109093031.GC4563@fs.tum.de>
References: <20021101223645.GA216@chiara.cavy.de> <1036194155.14932.17.camel@sonja.de.interearth.com> <20021107195343.GA961@chiara.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107195343.GA961@chiara.cavy.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 08:53:43PM +0100, Heinz Diehl wrote:
> On Sat Nov 02 2002, Daniel Egger wrote:
> 
> > Nov  1 16:10:20 nicole kernel: solo1: version v0.19 time 11:19:52 Apr 14 2002
> > Nov  1 16:10:20 nicole kernel: PCI: Found IRQ 10 for device 00:13.0
> > Nov  1 16:10:20 nicole kernel: IRQ routing conflict for 00:13.0, have irq 3, want irq 10
>  
> > This is also an Apollo/MVP3 chipset. Other than that the soundcard seems
> > to work fine.
> 
> Just to mention it: my network card also works flawlessly with this
> curious "irq routing conflict"....

<AOL>

PCI: Found IRQ 11 for device 00:0a.0
IRQ routing conflict for 00:0a.0, have irq 10, want irq 11
eth0: RealTek RTL-8029 found at 0xe800, IRQ 10, 00:40:05:32:EB:19.


The card works fine, this is on a MVP3 running 2.4.20-rc1.

</AOL>

> Greetings, Heinz.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

