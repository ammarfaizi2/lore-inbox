Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTCLWxu>; Wed, 12 Mar 2003 17:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262103AbTCLWwX>; Wed, 12 Mar 2003 17:52:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18692 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262087AbTCLWvN>;
	Wed, 12 Mar 2003 17:51:13 -0500
Date: Thu, 13 Mar 2003 01:05:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Zack Brown <zbrown@tumblerings.org>,
       Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030313000545.GE5958@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0303090401160.32518-100000@serv> <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > A separate repository doesn't have this problem
> 
> You're wrong.
> 
> The problem is _distribution_. In other words, two people rename the same 
> file. Or two people rename two _different_ files to the same name. Or two 
> people create two different files with the same name. What happens when 
> you merge?
> 
> None of these are issues for broken systems like CVS or SVN, since they 

Actually this does not have much to do
with central repository. prcs has central
repository, too, but it has branches
(=multiple repositories in bk); so
yes you have the very same problem.

prcs does not have problems like trust
and non-synchronized time, through.
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

