Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSJ3MII>; Wed, 30 Oct 2002 07:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264687AbSJ3MII>; Wed, 30 Oct 2002 07:08:08 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62204 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264686AbSJ3MIH>; Wed, 30 Oct 2002 07:08:07 -0500
Date: Wed, 30 Oct 2002 13:14:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: jt@hpl.hp.com
cc: James McKenzie <james@fishsoup.dhs.org>, <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [2.5 patch] allow only one Toshiba Type-O IR Port driver in the
 kernel
In-Reply-To: <20021029172932.GE32449@bougret.hpl.hp.com>
Message-ID: <Pine.NEB.4.44.0210301309590.19481-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Jean Tourrilhes wrote:

>...
> > But as stated above my patch doesn't affect the case when both drivers are
> > modular which is usually the desired setup when you want to switch between
> > the two drivers.
>
> 	I personally prefer to make the driver code cleaner rather
> than making the config/Makefile rules more complex. I believe that in
> the long run, it always pay to keep things simple.
> 	But, I'm not religious about it.

The only thing I'm religious about is that a kernel with a valid .config
shouldn't produce compile errors.

> 	How do we proceed ? Do you want to send patches yourself
> directly, or do you want to wait until I send my next IrDA update ?

I'll wait until you send the fix you prefer at the next IrDA update.

> 	Regards,
> 	Jean

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


