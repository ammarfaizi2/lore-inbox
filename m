Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314749AbSDVUrn>; Mon, 22 Apr 2002 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314742AbSDVUrm>; Mon, 22 Apr 2002 16:47:42 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:25808 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314749AbSDVUre>;
	Mon, 22 Apr 2002 16:47:34 -0400
Date: Mon, 22 Apr 2002 16:47:28 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020422164728.H20999@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204211158160.30929-100000@twinlark.arctic.org> <E16zL7i-0001I2-00@starship> <20020422134059.B11216@havoc.gtf.org> <E16zLb1-0001IX-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:57:55PM +0200, Daniel Phillips wrote:
> On Monday 22 April 2002 19:40, Jeff Garzik wrote:
> > On Sun, Apr 21, 2002 at 07:27:37PM +0200, Daniel Phillips wrote:
> > >   1) It would be equally as useful as a URL
> > 
> > Maybe 5% less useful or so.  There are reasons we move other
> > (non-controversial) docs into the kernel source.  100% of these docs can
> > be URLs.
> > 
> > >   2) It would not consume download bandwidth
> > 
> > This is a silly argument that dean gaudet dismembered.  It's 12K
> > compressed and not your main argument at all.
> > 
> > 
> > >   3) It would show some sensitivity to the concerns of those who are
> > >      uncomfortable with the license.
> > 
> > I agree.
> > 
> > So, I believe points #1 and #2 are silly, and #3 is your core argument.
> 
> I think you stated that #1 is only 5% silly, by implication, 95% unsilly.
> Two out of three ain't bad.

I will grant you that :) but clarify:

Making is a URL is no big deal and shouldn't be a point of discussion,
as I think #2 is no big deal and shouldn't be a point of discussion.

The real question, as I understand it, is whether or not the kernel doc
should be in the kernel source or not.  If the answer is 'no', then I
fully support making it a URL, or printing it out the back of
phonebooks, or whatever means of distribution :)

But I am arguing that the answer 'no' has not been justified yet...


> > And I agree that it would show sensitivity towards those people who
> > dislike the BK license.
> > 
> > That said, I still think removing the doc is a hideously wrong thing
> > to do.
> 
> I agree.  (/me listens for sound of garzik hitting floor)  The doc was never
> to be removed, it was to be moved.  Read the original mail please.  I repeat:
> I *like* your docs, in fact I think they are excellent docs.  I just don't
> like to see them sitting in Documentation, for reasons we've been over in
> some detail.

This is really a semantic argument...  I shorten "removing from kernel
sources" as "removing", because (correct me here) we are discussing what
we want to see in the kernel sources, and what we do not want to see in
the kernel sources.

Even without an official web site, the BK doc would live on in kernel
archives if nowhere else.

If it makes things more clear, I can use my same arguments, and do a
search-n-replace of "remove from kernel sources" to "move from kernel
sources to elsewhere."  To me, it's the same thing.


> > I see the action of BK doc removal as encouraging some strict
> > notion of what we can and cannot discuss, inside the kernel sources.
> > _That_ is the free speech aspect.
> > 
> > I see enforcing a strict notion of acceptable speech in the kernel
> > sources as a very bad thing for the Linux project.
> > 
> > I'm not asking you to agree -- but do you even understand my viewpoint here?
> 
> I do.  I don't agree with you that any of this has something to do with free 
> speech, but I'm willing to accept that you view the kernel source as a kind of
> podium.

I conjecture, then, that moving the BK doc to satisfy sensitivies is
also acknowledge of the kernel sources as a podium :)


> > > I really don't see how changing out the files for a url qualifies as
> > > the "worst way" of addressing the issue.  If Larry unretracts his offer
> > > to host the files - and I fully expect he will do that after some period
> > > of indulging in his wounded bird act - then by definition the documentation
> > > will always be available exactly when and where needed.  Is there *anybody*
> > > here who'd have further license-related complaints about Bitkeeper if that
> > > were done?  (Speak or forever hold your peace.)
> > 
> > First, I can host the doc.  And will, if there is justification.
> > I do not see a justification.  Larry is irrelevant.
> 
> To this discussion?  Debatable.  I'll go with you on that for now though, and
> see where it leads.

hehe


> > Second, I guarantee that license-related complaints about BitKeeper will
> > continue to exist, regardless of the doc's location.  Moving the doc
> > does absolutely nothing to assauge bad feelings about the BK license.
> 
> It would for me, others mileage may vary.

Interesting.  And I will claim up-front that I don't understand this
one bit.  BitKeeper would still be in use with its odious license,
and people will still say the "BitKeeper mafia" exists, even if the
document is moved.

	Jeff



