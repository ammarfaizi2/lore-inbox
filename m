Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSDTWUI>; Sat, 20 Apr 2002 18:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313168AbSDTWUH>; Sat, 20 Apr 2002 18:20:07 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:1935 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313060AbSDTWUF>;
	Sat, 20 Apr 2002 18:20:05 -0400
Date: Sat, 20 Apr 2002 18:20:03 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420182003.A18057@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020420170747.B14186@havoc.gtf.org> <E16ygRk-0000bR-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 12:01:35AM +0200, Daniel Phillips wrote:
> Let me turn that around.  Which bitkeeper patches have been posted to lkml and
> generated significant amounts of discussion on lkml in the last week?  Versus
> how many lines of bitkeeper patches applied to Linus's tree?

Prior to BK, many people still emailed patches privately to Linus:
me, DaveM, Alan, Al, GregKH, ...  You might consider private email
stealth, but usually the changes are either (a) obvious or (b)
previously discussed.  With BK, the situation is the same.

So your argument is red herring -- which changes are _newly stealthed_
under BK?  Do you have even ONE objectionable example?

BK only changes the medium of transmission of patches to Linus,
and gives us _more_ information about submittors than pre-BK.


> The next question you might ask is: are there more BK patches or
> more Non-BK, in total, on and off lkml?  I don't have statistics at
> hand but I'm willing to bet that there are more BK patches, because
> that is how the bulk of the grunt tree maintainance is getting
> done these days.

> My conclusion: though there are more BK patches being applied to Linus's
> tree than non-BK,

So... your conclusion is based on a guess which is based on a guess.

Even if your conclusion is correct (it might be), how do you use
that to support the argument that, less discussion occurs due to BK?
As I mentioned, most merging with Linus occured in private anyway.
If you want to argue against that, go ahead.  But don't try to blame
BitKeeper for it.

If there are _specific solutions_ that can be implemented to equalize
things with BK versus non-BK developers, please, chime in.  I think the
daily snapshot idea is a good one.  Deleting a document, and nothing
else, accomplishes no forward progress (except maybe spawning this
discussion on the evils of BK).

	Jeff



