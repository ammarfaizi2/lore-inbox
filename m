Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbSJFD3h>; Sat, 5 Oct 2002 23:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbSJFD3h>; Sat, 5 Oct 2002 23:29:37 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:404 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S263284AbSJFD3g>; Sat, 5 Oct 2002 23:29:36 -0400
Date: Sat, 5 Oct 2002 23:35:13 -0400
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       Ben Collins <bcollins@debian.org>
Subject: Re: New BK License Problem?
Message-ID: <20021006033513.GA21253@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Ben Collins <bcollins@debian.org>
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <20021004140802.E24148@work.bitmover.com> <20021005175437.GK585@phunnypharm.org> <20021005112552.A9032@work.bitmover.com> <20021005184153.GJ17492@marowsky-bree.de> <20021005190638.GN585@phunnypharm.org> <3D9F3C5C.1050708@redhat.com> <20021005124321.D11375@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021005124321.D11375@work.bitmover.com>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 12:43:21PM -0700, Larry McVoy wrote:
> > patches in the kernel every day.  Now this isn't possible anymore without
> 
> Nonsense.  There are all sorts of people who have taken the BK trees and
> made the patch snapshots available on timely basis.  Garzik's done it,
> Woodhouse has done it, Rik has done it, I'm sure there are piles more.

I promised myself to stay out of this one, but according to the wording
of your license they all thereby losts their licenses because they
'developed a product which competes with the BK software' as the GNU
patches they make available are clearly allowing others to make things
accessible with competing products. And to automate it they must have
developed some sort of script to pull the changesets out of the BK
repository.

Similarily any fs developer is creating something that can store
multiple revisions of a source tree which, albeit inefficiently, has
similar capabilities. And if someone uses a filesystem to store his
development trees instead of BK, it is clearly a competing product.

I do see your point and consider it valid, you have to make a living
too, but I can also see how the wording of the license could be
'misinterpreted'. That 'reasonable opinion of BitMover' is somewhat
of a safety net which probably would nullify the violations I mentioned
above.

Jan

