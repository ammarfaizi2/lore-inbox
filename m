Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266089AbSKFVAg>; Wed, 6 Nov 2002 16:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbSKFVAg>; Wed, 6 Nov 2002 16:00:36 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46589 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266089AbSKFVAf>; Wed, 6 Nov 2002 16:00:35 -0500
Date: Wed, 6 Nov 2002 22:07:07 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Marc A. Volovic" <marc@bard.org.il>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Pannaga Bhushan <bhushan@multitech.co.in>, linux-kernel@vger.kernel.org
Subject: Re: A hole in kernel space!
Message-ID: <20021106210707.GD19580@fs.tum.de>
References: <20021106134935.GA24234@glamis.bard.org.il> <Pine.LNX.3.95.1021106085810.3962A-100000@chaos.analogic.com> <20021106160934.GA25325@glamis.bard.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106160934.GA25325@glamis.bard.org.il>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 06:09:34PM +0200, Marc A. Volovic wrote:
> 
> I do not alloc/dealloc every time ;-). I allocate at boot and do not
> bother deallocating at all. The module just uses that allocated memory
> and maps it into the filesystem namespace.
>...

Read pages 221-223 in

   Alessandro Rubini and Jonathan Corbet.  Linux device drivers.
   O'Reilly, second edition, 2001.  Online version:
   http://www.xml.com/ldd/chapter/book/index.html


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

