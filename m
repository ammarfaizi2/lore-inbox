Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTAQL3E>; Fri, 17 Jan 2003 06:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTAQL3E>; Fri, 17 Jan 2003 06:29:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3271 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267493AbTAQL3D>; Fri, 17 Jan 2003 06:29:03 -0500
Date: Fri, 17 Jan 2003 12:37:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117113757.GY2333@fs.tum.de>
References: <Pine.LNX.4.44.0301161826430.8879-100000@penguin.transmeta.com> <20030117095921.GW2333@fs.tum.de> <wrpel7cxefz.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpel7cxefz.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jan 17, 2003 at 11:23:28AM +0100, Marc Zyngier wrote:
> >>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:
> 
> Adrian> On Thu, Jan 16, 2003 at 06:28:03PM -0800, Linus Torvalds wrote:
> >> ...
> >> o EISA sysfs updates to 3c509 and 3c59x drivers
> >> ...
> 
> Adrian> This change browke the compilation of 3c509 with CONFIG_PM:
> 
> Can you try this patch (compiles, but otherwise untested) ?

Since I'm doing compile-only tests but don't have the hardware available 
all I can do is to confirm that this patch fixes the compilation.

> Thanks,
> 
>         M.
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

