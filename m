Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSE2XTI>; Wed, 29 May 2002 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSE2XTH>; Wed, 29 May 2002 19:19:07 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:24987
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S315709AbSE2XTF>; Wed, 29 May 2002 19:19:05 -0400
Date: Wed, 29 May 2002 19:18:57 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Thunder from the hill <thunder@ngforever.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Paul P Komkoff Jr <i@stingr.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <Pine.LNX.4.44.0205291655460.4599-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0205291909440.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Thunder from the hill wrote:

> Hi,
> 
> On Wed, 29 May 2002, Nicolas Pitre wrote:
> > So it looks like someone else will have to volunteer to split kbuild25 into
> > multiple small patches and feed them "piecemeal" to Linus before we ever see
> > it into the kernel tree.
> 
> Well, I would, but... wasn't Kai on that already?

No.

Kai is only banging on the current build system to make it somewhat more
palatable.  While this is certainly useful today, those efforts would
probably produce a better system in the long run if they were directed at
kbuild25 instead.

Or maybe people just don't care enough about the build system for kbuild25
to be worth it...


Nicolas

