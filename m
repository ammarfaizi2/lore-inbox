Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSE2Wn4>; Wed, 29 May 2002 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSE2Wnz>; Wed, 29 May 2002 18:43:55 -0400
Received: from www.transvirtual.com ([206.14.214.140]:30483 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315619AbSE2Wnx>; Wed, 29 May 2002 18:43:53 -0400
Date: Wed, 29 May 2002 15:43:37 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Linux 2.5.19
In-Reply-To: <20020529214739.F30585@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10205291443020.19493-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Due to a error with merging some stuff from a older DJ tree. I fixed it
> > in the fbdev BK repository.
> 
> They haven't *been* in any DJ tree.

    Looking threw the many patches I have from people I did grab it from 
patch-2.5.15-rmk1. It is right above the fbcmap.c fix which I did need.
That is where I go it from. Thank you for that fix.  

    While grabbing that fix I noticed what a appeared to be a simple two
line fix for the cyber2000fb driver. Actually I was tempted to port the
whole driver over to the new api but I didn't because I feared you be
ticked off. Especially since I don't have the hardware. The only drivers I
have ported over are the ones that are really simple. I touched the
anakin driver because of this reason. The complex one where I don't have
the hardware I don't touch. Now that we have enough functionally drivers
people can see the new changes needed to be done. 

> Why the fuck should I go around finding and testing peoples trees when I
> haven't submitted the stuff to them?  

    Look here. I'm not looking for trouble or to upset anyone. I know alot
of the fbdev driver maintainers are too busy to properly maintain the
drivers. Several have told me this. Or the drivers have been abandon.
Plus the docs have been shotty for porting to the new api. I am willing to
do extra work and port these drivers to save the maintainers time. I'm
not going to do a perfect port but I do hope what work I did do will help 
them out.  

    I do admit and apologize for not properly saying which drivers have
been altered. I will make a special note of doing that in the future.
Especially since very few actually look at my patches.
           




