Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSDTRvc>; Sat, 20 Apr 2002 13:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314691AbSDTRvb>; Sat, 20 Apr 2002 13:51:31 -0400
Received: from bitmover.com ([192.132.92.2]:45462 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314690AbSDTRv3>;
	Sat, 20 Apr 2002 13:51:29 -0400
Date: Sat, 20 Apr 2002 10:51:25 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420105125.B29646@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204201006280.11450-100000@penguin.transmeta.com> <E16ycFR-0000Vg-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 07:32:36PM +0200, Daniel Phillips wrote:
> On Saturday 20 April 2002 19:09, Linus Torvalds wrote:
> > On Fri, 19 Apr 2002, Daniel Phillips wrote:
> > > 
> > > And some have a more difficult one.  So it goes.
> > 
> > How? 
> 
> Those who now chose to carry out their development using the patch+email
> method, and prefer to submit everything for discussion on lkml before it
> gets included are now largely out of the loop.  Things just seem to *appear*
> in the tree now, without much fanfare.  That's my impression.
> 
> Rather than Linux development becoming more open, as I'd hoped with the
> advent of Bitkeeper, it seems to be turning more in the direction of 
> becoming a closed club.  This may be fun if you're a member of the club.

You are sort of right and sort of wrong.  The changes are mostly ending
up in some BK tree and Linus pulls from that tree.  Most of the trees
are on bkbits.net (there are about 130 different ones at last count).

The problem is that there is not an easy way to get a handle on what is
in Linus' tree and what is not, and it's just insane to ask people to 
sit around and diff the trees even if BK does make that process somewhat
easier.

An obvious improvement would be to have an "overview" web page which showed
you the list of changes not present in Linus' tree but present in any of
the other trees.  Probably sorted by tree so you could see

	linuxusb.bkbits.net/linux-2.5
	    37 changesets (click here for details)
	gkernel.bkbits.net/vm
	    12 changesets (click here for details)

Etc.

If you dump the licensing discussion and think about how BK could help 
you, you can see we are half to an improvement over the "mail to the 
list" model.  The problem I had with the "mail to the list" model was
that it was easy to miss something and then not realized that you
had missed it.  Now a lot of that stuff is ending up on bkbits.net
and if there was a way to say "tell me everything that is there but
not here", that would be a distinct improvement, it means that the 
"mail" is archived and you can find it when you want it.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
