Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315293AbSEYUb2>; Sat, 25 May 2002 16:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSEYUb1>; Sat, 25 May 2002 16:31:27 -0400
Received: from dsl-213-023-040-043.arcor-ip.net ([213.23.40.43]:62671 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315293AbSEYUb0>;
	Sat, 25 May 2002 16:31:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Sat, 25 May 2002 22:30:44 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17BiBY-0003nt-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 May 2002 19:27, Linus Torvalds wrote:
> On Sat, 25 May 2002, Robert Schwebel wrote:
> > This is only correct for open-loop applications. Most real life apps are
> > closed-loop.
> 
> Most real life apps have nothing to do with hard-RT.

What kind of argument is that?  As with many kernel features, "it may not be
the common case, but if it's *your* case, you care a lot".

A short time ago I made my living by programming large factory machines that
can kill people in an instant.  I would have loved to use Linux, but it was
not ready at the time.  As long as core developers continue to ignore the
need for realtime capability in the kernel itself - as opposed to waving hands
and saying "just handle that running Linux as a task under some other OS" - 
Linux will continue to not be ready.  We have a choice of either addressing
the technical issues, or just admitting that Linux can't cut it in a factory.

This is the same dilemma as the one that lead to you finally realizing that
it really matters whether people's MP3 players skip or not.

-- 
Daniel
