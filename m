Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272044AbRHVQRo>; Wed, 22 Aug 2001 12:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272046AbRHVQRd>; Wed, 22 Aug 2001 12:17:33 -0400
Received: from beppo.feral.com ([192.67.166.79]:60943 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S272045AbRHVQRV>;
	Wed, 22 Aug 2001 12:17:21 -0400
Date: Wed, 22 Aug 2001 09:17:07 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: Jes Sorensen <jes@sunsite.dk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetopia.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010822084231.H2189-100000@wonky.feral.com>
Message-ID: <20010822091212.M2189-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We could ask them where it is.

I've asked their tech support folks about where and how big in flash the RISC
code is for all their cards. I have other people I can ask too. Let's see if
they're helpful or open about it.

I'm not as sensitive to the bloat issues as I should be- I suppose because I
tend to see all of USB as bloat myself :).. I tend to think that the generic
shipping kernel case should have all of the firmware images there to download
from the driver.

That said, it *would* be nice to give people some tools to strip things down
if they really want, out of a 2GB system, a couple hundred kbytes back that
can the be gobbled up by something really hungry for it like a memory leak in
X or Matzohilla or something :-)....

-matt


