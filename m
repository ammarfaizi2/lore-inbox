Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbTCLWvk>; Wed, 12 Mar 2003 17:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTCLWvj>; Wed, 12 Mar 2003 17:51:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11012 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262052AbTCLWus>;
	Wed, 12 Mar 2003 17:50:48 -0500
Date: Thu, 13 Mar 2003 00:23:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030312232311.GC5958@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v_14m_1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b98v_14m_1@penguin.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >So, basically, if branch was killed and recreated after each merge
> >from mainline, problem would be solved, right?
> 
> Wrong.
> 
> Now think three trees.  Each merging back and forth between each other. 

> Or, in the case of something like the Linux kernel tree, where you don't
> have two or three trees.  You've got at least 20 actively developed
> concurrent trees with branches at different points. 

Yep, but only three trees are interesting
for me (your's and Andi's) and most
developers only care about your tree,
so simplifications should be possible.

> Trust me. CVS simple CANNOT do this. You need the full information.
> 
> Give it up.  BitKeeper is simply superior to CVS/SVN, and will stay that
> way indefinitely since most people don't seem to even understand _why_
> it is superior. 

Actually by now I understand that prcs,
not cvs is the closest thing... Actually
its .prj file looks similar to bk's ChangeSet
file.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

