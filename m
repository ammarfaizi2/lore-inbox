Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSFBGwc>; Sun, 2 Jun 2002 02:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317009AbSFBGwb>; Sun, 2 Jun 2002 02:52:31 -0400
Received: from dsl-213-023-039-114.arcor-ip.net ([213.23.39.114]:36496 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316848AbSFBGwa>;
	Sun, 2 Jun 2002 02:52:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
Subject: Re: KBuild 2.5 Impressions
Date: Sun, 2 Jun 2002 08:51:21 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Message-Id: <E17EPCz-0000Jr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 June 2002 06:03, you wrote:
> On Fri, 31 May 2002, Daniel Phillips wrote:
> What you and other very vocal proponents of kbuild25 don't understand is 
> that you need break it up __functionally__. That is, add one feature at a 
> time. That way, good features can be added without much of a discussion, 
> and debatable features can be, well, debated.
> 
> Unfortunately, I don't see Keith doing this anytime soon. He's too much in 
> love with his baby to risk seeing parts of it being thrown away, so he's 
> taking an all-or-nothing attitude.

Fortunately, he's got help now:

   http://marc.theaimsgroup.com/?a=102296100300003&r=1&w=2

> Fortunately, it is precisely what Kai is doing. He deserves a big THANKS 
> for doing it, not your silly bashing. I also saw some good work on this 
> from Sam Ravnborg on the list.

If I got the impression that Kai was actually trying to work with the team,
I'd thank him for that.  He appears to be doing just the opposite, and I
stand by my comment that that is divisive.  He could accomplish the same
thing result he wants - patching up old kbuild - and bring parts of kbuild
2.5 into the tree, reducing the size of that patch *at the same time*,
instead of (apparently) trying to marginalize that work.  That is what I'd
call cooperation.

We have a perfect - and rare - situation here where the two can coexist in
the same tree, and may the best and fastest eventually predominate.  Let's
take advantage of that: let's have both in parallel for a while.

-- 
Daniel

