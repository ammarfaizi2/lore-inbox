Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292422AbSBPQfG>; Sat, 16 Feb 2002 11:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292424AbSBPQe5>; Sat, 16 Feb 2002 11:34:57 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38664
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292422AbSBPQej>; Sat, 16 Feb 2002 11:34:39 -0500
Date: Sat, 16 Feb 2002 11:08:57 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        That Linux Guy <thatlinuxguy@hotmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216110857.B32129@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Nicolas Pitre <nico@cam.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	That Linux Guy <thatlinuxguy@hotmail.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020216095039.L23546@thyrsus.com> <Pine.LNX.4.44.0202161055030.16872-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202161055030.16872-100000@xanadu.home>; from nico@cam.org on Sat, Feb 16, 2002 at 11:06:49AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org>:
> Make the whole thing ___***IDENTICAL***___ to CML1.
> Do a formal translation of CML1 into CML2.
> 
> Show us that you are clever enough to do so, even if it's not particularly 
> interesting and challenging to you.
> 
> Show us that you can listen to this simple feedback.
> 
> Acknoledge that the feedback went through.
> 
> Don't tell us that's not doable.  Do it and show us that you can do a 
> perfect translation of CML1 into CML2 with all CML1 structural flaws.
> 
> Submit that, and only that.
> 
> Do you copy?  Please acknoledge that you listened to this very feedback.

I listened.

Would you ask someone designing a new VM to make it crash and hang exactly
the same way the old one did?

Do you demand that a rewrite of a disk driver have the same data-corruption
bugs as the original before it can go into the tree, and tell the developer
to add fixes later?

Pragmatically, the point of rewriting a system is to *fix bugs*.

Let's suppose we ignored this point for a moment.  Let's also suppose
that what you were demanding were not rendered horribly painful and
perhaps impossible by the difference between CML1's imperative style
and CML2's declarative one.

How the hell do you possibly think I could possibly stay motivated under
that constraint?  Nobody is paying me to do this.  I'm a volunteer; I
need to produce good art, not waste time slavishly recreating old errors
just because a few people are unreasonably fearful of change.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
