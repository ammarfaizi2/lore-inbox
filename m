Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSDTWeU>; Sat, 20 Apr 2002 18:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSDTWeT>; Sat, 20 Apr 2002 18:34:19 -0400
Received: from dsl-213-023-039-128.arcor-ip.net ([213.23.39.128]:46733 "EHLO
	starship") by vger.kernel.org with ESMTP id <S313187AbSDTWeR>;
	Sat, 20 Apr 2002 18:34:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 00:34:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16ygRk-0000bR-00@starship> <20020420182003.A18057@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ygxR-0000cY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 April 2002 00:20, Jeff Garzik wrote:
> On Sat, Apr 20, 2002 at 12:01:35AM +0200, Daniel Phillips wrote:
> > Let me turn that around.  Which bitkeeper patches have been posted to lkml and
> > generated significant amounts of discussion on lkml in the last week?  Versus
> > how many lines of bitkeeper patches applied to Linus's tree?
> 
> Prior to BK, many people still emailed patches privately to Linus:
> me, DaveM, Alan, Al, GregKH, ...  You might consider private email
> stealth, but usually the changes are either (a) obvious or (b)
> previously discussed.  With BK, the situation is the same.
> 
> So your argument is red herring -- which changes are _newly stealthed_
> under BK?  Do you have even ONE objectionable example?

Of course I do: the patch to add the Bk files to Documentation.  I will not
call that objectionable - I object to it, but that is not the same thing.  I
will call it 'not discussed' when it should have been.

> BK only changes the medium of transmission of patches to Linus,
> and gives us _more_ information about submittors than pre-BK.

I'm not arguing that BK is not a good way to do the grunt maintainance work.
I think it is, and that's great.  Heck, I'm not arguing against Bitkeeper *at
all*.  I'm arguing against building the bitkeeper documentation into the
kernel tree, giving the impression that Bitkeeper is *required* for
submitting patches.

> > The next question you might ask is: are there more BK patches or
> > more Non-BK, in total, on and off lkml?  I don't have statistics at
> > hand but I'm willing to bet that there are more BK patches, because
> > that is how the bulk of the grunt tree maintainance is getting
> > done these days.
> 
> > My conclusion: though there are more BK patches being applied to Linus's
> > tree than non-BK,
> 
> So... your conclusion is based on a guess which is based on a guess.

Check it if you think I'm wrong.

> Even if your conclusion is correct (it might be), how do you use
> that to support the argument that, less discussion occurs due to BK?

We haven't established that, we do see a strong correlation.  But think.
It's obvious anyway, why discuss anything in public when you don't have
to?  Just push it straight to Linus's tree, why bother with formalities?
It's so easy.

> As I mentioned, most merging with Linus occured in private anyway.
> If you want to argue against that, go ahead.  But don't try to blame
> BitKeeper for it.

I sense that the discussion of patches on lkml is in decline and I do
blame Bitkeeper.  Think I'm being paranoid?  Prove me wrong.

> If there are _specific solutions_ that can be implemented to equalize
> things with BK versus non-BK developers, please, chime in.  I think the
> daily snapshot idea is a good one.

I think so too, having heard more about the idea.

> Deleting a document, and nothing
> else, accomplishes no forward progress (except maybe spawning this
> discussion on the evils of BK).

Larry already agreed to it, and to provide a new home for it.  Linus
said 'don't be silly', but that was a long way back.  So that's where
it stands.

-- 
Daniel
