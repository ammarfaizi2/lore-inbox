Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbTCLWxu>; Wed, 12 Mar 2003 17:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262092AbTCLWwS>; Wed, 12 Mar 2003 17:52:18 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18436 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262085AbTCLWvM>;
	Wed, 12 Mar 2003 17:51:12 -0500
Date: Thu, 13 Mar 2003 01:13:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030313001332.GF5958@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com> <Pine.LNX.4.44.0303090504140.32518-100000@serv> <m14r6ck6jd.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14r6ck6jd.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I don't know, if the problem really changes that much.  How do
> you pick a globally unique inode number for a file? 

Use <emailaddress>@locallyuniq. Every
developer should have an email, right? :-)

> And then
> how do you reconcile this when people on 2 different branches create
> the same file and want to merge their versions together?

That's conflict, and user interaction is
neccessary at this point.

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

