Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSDTWyb>; Sat, 20 Apr 2002 18:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313168AbSDTWyb>; Sat, 20 Apr 2002 18:54:31 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:42895 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313060AbSDTWya>;
	Sat, 20 Apr 2002 18:54:30 -0400
Date: Sat, 20 Apr 2002 18:54:28 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020420185428.D18057@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16ygRk-0000bR-00@starship> <20020420182003.A18057@havoc.gtf.org> <E16ygxR-0000cY-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 12:34:19AM +0200, Daniel Phillips wrote:
> On Sunday 21 April 2002 00:20, Jeff Garzik wrote:
> > On Sat, Apr 20, 2002 at 12:01:35AM +0200, Daniel Phillips wrote:
> > > Let me turn that around.  Which bitkeeper patches have been posted to lkml and
> > > generated significant amounts of discussion on lkml in the last week?  Versus
> > > how many lines of bitkeeper patches applied to Linus's tree?
> > 
> > Prior to BK, many people still emailed patches privately to Linus:
> > me, DaveM, Alan, Al, GregKH, ...  You might consider private email
> > stealth, but usually the changes are either (a) obvious or (b)
> > previously discussed.  With BK, the situation is the same.
> > 
> > So your argument is red herring -- which changes are _newly stealthed_
> > under BK?  Do you have even ONE objectionable example?
> 
> Of course I do: the patch to add the Bk files to Documentation.  I will not
> call that objectionable - I object to it, but that is not the same thing.  I
> will call it 'not discussed' when it should have been.

It was requested by Linus to be in the tree as a convenience, because he
and I and others were constantly bouncing it to new people.

I don't see the point of discussing such an obvious patch, outside of
ideological grounds.  And when we start making decisions based on
ideology and politics rather than technical merit, we can all go home.



> > BK only changes the medium of transmission of patches to Linus,
> > and gives us _more_ information about submittors than pre-BK.
> 
> I'm not arguing that BK is not a good way to do the grunt maintainance work.
> I think it is, and that's great.  Heck, I'm not arguing against Bitkeeper *at
> all*.  I'm arguing against building the bitkeeper documentation into the
> kernel tree, giving the impression that Bitkeeper is *required* for
> submitting patches.

I think the conclusion that BitKeeper is required, because of the
presence of this documentation, is ludicrous.  And I have already stated
many times that I think objecting to the presence of the doc solely on
ideological grounds is also ludicrous.

Linus repeatedly says GNU patches are still acceptable, did you miss that?



> > Even if your conclusion is correct (it might be), how do you use
> > that to support the argument that, less discussion occurs due to BK?
> 
> We haven't established that, we do see a strong correlation.  But think.
> It's obvious anyway, why discuss anything in public when you don't have
> to?  Just push it straight to Linus's tree, why bother with formalities?
> It's so easy.

This "it's easy" argument can easily be applied to the pre-BK days.
Straight-to-Linus-without-discussion is obviously faster, regardless of
whether BK is used or not.


> > As I mentioned, most merging with Linus occured in private anyway.
> > If you want to argue against that, go ahead.  But don't try to blame
> > BitKeeper for it.
> 
> I sense that the discussion of patches on lkml is in decline and I do
> blame Bitkeeper.  Think I'm being paranoid?  Prove me wrong.

huh??  "I <think this>.  Am I wrong?  Prove it."

Typically, one is expected to prove their arguments :)

Can you offer any evidence of patches that would have been discussed, in
the pre-BK days, that are no longer discussed?  Support your argument,
please.


> > Deleting a document, and nothing
> > else, accomplishes no forward progress (except maybe spawning this
> > discussion on the evils of BK).
> 
> Larry already agreed to it, and to provide a new home for it.  Linus
> said 'don't be silly', but that was a long way back.  So that's where
> it stands.

IOW, it stands at 'don't be silly'.

IMO the acceptance of your patch would indicate that Linus has started
accepting patches based on something other than technical merit.
_There_ is your slippery slope we should avoid at all costs.

	Jeff



