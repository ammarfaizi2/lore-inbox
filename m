Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSE3CSE>; Wed, 29 May 2002 22:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSE3CSD>; Wed, 29 May 2002 22:18:03 -0400
Received: from dsl-213-023-039-142.arcor-ip.net ([213.23.39.142]:33494 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316210AbSE3CSB>;
	Wed, 29 May 2002 22:18:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 2.5.19 - What's up with the kernel build?
Date: Thu, 30 May 2002 04:17:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Paul P Komkoff Jr <i@stingr.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205292019090.9971-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17DFVQ-0007Zc-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 May 2002 04:00, Kai Germaschewski wrote:
> On Wed, 29 May 2002, Jeff Garzik wrote:
> > Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> > he wanted an evolution to a new build system... not an unreasonable 
> > request to at least consider.  Despite Keith's quality of code (again -- 
> > I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> > very "take it or leave it dammit".  Not the best way to win friends and 
> > influence people.
> > 
> > If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
> > work with Kai to integrate it into 2.5.x.
> 
> Oh well, it really wasn't my intention to start the good old kbuild-2.5
> thread at all.
> 
> Anyway, I believe kbuild-2.5 has lots of useful ideas and I'll go pick 
> pieces - from kbuild-2.5, from dancing-makefiles, from stuff I've done 
> myself and work on improving the current build system. But I believe in 
> make, and don't think I'll move away from it.

I wish you would just join the kbuild team and work with them instead of
against them.  And what makes you think that it doesn't use make?

-- 
Daniel
