Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263152AbSJGSYH>; Mon, 7 Oct 2002 14:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263153AbSJGSYH>; Mon, 7 Oct 2002 14:24:07 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263152AbSJGSYD>;
	Mon, 7 Oct 2002 14:24:03 -0400
Date: Mon, 7 Oct 2002 01:15:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nicolas Pitre <nico@cam.org>, Ulrich Drepper <drepper@redhat.com>,
       Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021007011512.B6352@elf.ucw.cz>
References: <3D9F3C5C.1050708@redhat.com> <Pine.LNX.4.44.0210051533310.5197-100000@xanadu.home> <20021005125412.E11375@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005125412.E11375@work.bitmover.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have never looked closer at bk than I had to be able to check out the
> > > latest sources.  I'm not doing any development with it and I'm not
> > > checking in anything using bk.
> > 
> > What about Larry making available a special version of BK that would only be
> > able to perform checkouts?  
> > 
> > This special version could have a less controversial license, even be GPL
> > with source.  This only to provide a tool to extract data out of public BK
> > repositories (like Linus' kernel repository) for people who don't intend or
> > aren't willing to actually use the real value of the full fledged BK.
> 
> You can do this today.  rsync a BK tree and use GNU CSSC to check out
> the sources.  We maintained SCCS compat for exactly that reason.
> You've had the ability to ignore the BKL since day one if you aren't
> running the BK binaries.

Would someone write nice HOWTO do this?

And where's guarantee that you are not migrating BK to proprietary
format to cut this off once someone writes the HOWTO?
								Pavel
-- 
When do you have heart between your knees?
