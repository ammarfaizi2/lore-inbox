Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287306AbSBIU1Q>; Sat, 9 Feb 2002 15:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287421AbSBIU1H>; Sat, 9 Feb 2002 15:27:07 -0500
Received: from bitmover.com ([192.132.92.2]:24972 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S287306AbSBIU0v>;
	Sat, 9 Feb 2002 15:26:51 -0500
Date: Sat, 9 Feb 2002 12:26:49 -0800
From: Larry McVoy <lm@bitmover.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209122649.E13735@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20020209181213.GA32401@come.alcove-fr> <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com> <20020209201252.GD32401@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209201252.GD32401@come.alcove-fr>; from stelian.pop@fr.alcove.com on Sat, Feb 09, 2002 at 09:12:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I also push it to my private version on bkbits.net, and it is supposed to
> > be automatically then pushed onwards to the public one that is at
> > http://linux.bkbits.net:8080/linux-2.5, but the infrastructure for that
> > isn't yet working.
> 
> Ok, understood. While waiting for a 'proper' infrastructure', maybe
> a simple cron entry will do the job ? (since the bk pull from your
> private tree on bkbits to the public tree on bkbits is not supposed
> to ever fail or have merge errors...)

This is my problem.  You could help if you could tell me what exactly 
are the magic wands to wave such that you can ssh in without typing
a password.  I know about ssh-agent but that doesn't help for this, 
I know that in certain cases ssh lets me in without anything.  I thought
there was some routine where you ssh-ed one way and then the other way
and it left enough state that it trusted you, does any ssh genuis out 
there know what I'm talking about?  If I have this, I can set up the
cron job, I'm sure this is obvious and I'm just overlooking something
but I can't find it.

> Anyway, just did a 'bk pull' once again and noticed than linux.bkbits.net
> has again the latest version. Thanks! (or thanks Larry, whatever is 
> more appropriate :-)).

Yeah, I did it by hand.  Hopefully automated by the end of the day.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
