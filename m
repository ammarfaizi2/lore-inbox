Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136196AbRDVQY0>; Sun, 22 Apr 2001 12:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136199AbRDVQYR>; Sun, 22 Apr 2001 12:24:17 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:16903 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136196AbRDVQYB>;
	Sun, 22 Apr 2001 12:24:01 -0400
Date: Sun, 22 Apr 2001 12:24:22 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alexander Viro <viro@math.psu.edu>, Francois Romieu <romieu@cogenit.fr>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422122422.A29084@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Francois Romieu <romieu@cogenit.fr>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010422114648.G28605@thyrsus.com> <20010422133947.A21908@se1.cogenit.fr> <Pine.GSO.4.21.0104220819490.28681-100000@weyl.math.psu.edu> <20010422114648.G28605@thyrsus.com> <27871.987955675@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27871.987955675@redhat.com>; from dwmw2@infradead.org on Sun, Apr 22, 2001 at 05:07:55PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> esr@thyrsus.com said:
> >  I've had my nose rubbed in how things really work.  That's why I want
> > to fix the things that are broken about how things really work.
> 
> Then you're going to conjure up maintainers for the code which is currently 
> orphaned?

That's a *really* hard problem.  I don't know how to solve that one myself.

There are, however, other things that can be done to improve the way
things work.  Two things in particular: (1) to lower the technical and
social barriers to entry so that maintainers will conjure *themselves*
up with more frequency, and (2) to ... hmm, no, on reflection I think 
won't say that explicitly.  It would scare the conservatives too much.

However, if you think about it, you'll notice there's a common thread
in all the proposals I've been making.  If you still have trouble
seeing it, remember that I hack social systems as much as I hack code.
And consider lkml as a social machine.  And consider -- carefully --
the things it is demonstrably poor at.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Of all tyrannies, a tyranny exercised for the good of its victims may
be the most oppressive. It may be better to live under robber barons
than under omnipotent moral busybodies. The robber baron's cruelty may
sometimes sleep, his cupidity may at some point be satiated; but those
who torment us for our own good will torment us without end, for they
do so with the approval of their consciences.
	-- C. S. Lewis
