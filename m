Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbSJHBAz>; Mon, 7 Oct 2002 21:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262717AbSJHBAy>; Mon, 7 Oct 2002 21:00:54 -0400
Received: from mark.mielke.cc ([216.209.85.42]:57606 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262658AbSJHBAx>;
	Mon, 7 Oct 2002 21:00:53 -0400
Date: Mon, 7 Oct 2002 21:05:31 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Nicolas Pitre <nico@cam.org>
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021008010531.GA5962@mark.mielke.cc>
References: <20021007203714.GC7428@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0210071646170.913-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210071646170.913-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 04:54:47PM -0400, Nicolas Pitre wrote:
> On Mon, 7 Oct 2002, Pavel Machek wrote:
> > Of course Larry would have to do the changes "slowly" so people would
> > not notice. And every time someone complains he can repeat his "I'm
> > running business".
> At which point he'll piss of more and more kernel developers and lose them
> "slowly" as well, unless Linus himself gets pissed at which point the kernel
> user base will disappear in a single glitch.  Breaking SCCS compatibility
> "slowly" without anybody noticing before it's too late is a bit far fetched
> IMHO.

Also, I think Larry would find it difficult to 'slowly' break SCCS
compatibility. It either works, or it doesn't.

As somebody in a similar field, I find it odd that Larry bothered to
keep SCCS compatibility in the first place. If anything, it holds him
back for only questionable gain. It would not be unreasonable for
Larry to license an extractor utility under looser restrictions than
BK.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

