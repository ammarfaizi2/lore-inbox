Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315975AbSE2X3n>; Wed, 29 May 2002 19:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315980AbSE2X3k>; Wed, 29 May 2002 19:29:40 -0400
Received: from dsl-213-023-039-142.arcor-ip.net ([213.23.39.142]:16308 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315975AbSE2X3c>;
	Wed, 29 May 2002 19:29:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>, Thunder from the hill <thunder@ngforever.de>
Subject: Re: 2.5.19 - What's up with the kernel build?
Date: Thu, 30 May 2002 01:29:01 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Paul P Komkoff Jr <i@stingr.net>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205291909440.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DCsH-0006py-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2002 01:18, Nicolas Pitre wrote:
> On Wed, 29 May 2002, Thunder from the hill wrote:
> > 
> > On Wed, 29 May 2002, Nicolas Pitre wrote:
> > > So it looks like someone else will have to volunteer to split kbuild25 into
> > > multiple small patches and feed them "piecemeal" to Linus before we ever see
> > > it into the kernel tree.
> > 
> > Well, I would, but... wasn't Kai on that already?
> 
> No.
> 
> Kai is only banging on the current build system to make it somewhat more
> palatable.  While this is certainly useful today, those efforts would
> probably produce a better system in the long run if they were directed at
> kbuild25 instead.
> 
> Or maybe people just don't care enough about the build system for kbuild25
> to be worth it...

Omigod, don't even think that.  Kbuild 2.5 is faster and better than the
current kbuild.  I, for one, am waiting - impatiently - for the thing to get
in the tree.  The current build system is slow and unreliable, and don't even
think of trying to build two different architectures in the same source tree
at the same time.

-- 
Daniel
