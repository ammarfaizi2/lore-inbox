Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314375AbSDVR6g>; Mon, 22 Apr 2002 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314370AbSDVR6Z>; Mon, 22 Apr 2002 13:58:25 -0400
Received: from dsl-213-023-039-131.arcor-ip.net ([213.23.39.131]:41373 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314391AbSDVR5Y>;
	Mon, 22 Apr 2002 13:57:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sun, 21 Apr 2002 19:57:55 +0200
X-Mailer: KMail [version 1.3.2]
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204211158160.30929-100000@twinlark.arctic.org> <E16zL7i-0001I2-00@starship> <20020422134059.B11216@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16zLb1-0001IX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 April 2002 19:40, Jeff Garzik wrote:
> On Sun, Apr 21, 2002 at 07:27:37PM +0200, Daniel Phillips wrote:
> >   1) It would be equally as useful as a URL
> 
> Maybe 5% less useful or so.  There are reasons we move other
> (non-controversial) docs into the kernel source.  100% of these docs can
> be URLs.
> 
> >   2) It would not consume download bandwidth
> 
> This is a silly argument that dean gaudet dismembered.  It's 12K
> compressed and not your main argument at all.
> 
> 
> >   3) It would show some sensitivity to the concerns of those who are
> >      uncomfortable with the license.
> 
> I agree.
> 
> So, I believe points #1 and #2 are silly, and #3 is your core argument.

I think you stated that #1 is only 5% silly, by implication, 95% unsilly.
Two out of three ain't bad.

> And I agree that it would show sensitivity towards those people who
> dislike the BK license.
> 
> That said, I still think removing the doc is a hideously wrong thing
> to do.

I agree.  (/me listens for sound of garzik hitting floor)  The doc was never
to be removed, it was to be moved.  Read the original mail please.  I repeat:
I *like* your docs, in fact I think they are excellent docs.  I just don't
like to see them sitting in Documentation, for reasons we've been over in
some detail.

> I see the action of BK doc removal as encouraging some strict
> notion of what we can and cannot discuss, inside the kernel sources.
> _That_ is the free speech aspect.
> 
> I see enforcing a strict notion of acceptable speech in the kernel
> sources as a very bad thing for the Linux project.
> 
> I'm not asking you to agree -- but do you even understand my viewpoint here?

I do.  I don't agree with you that any of this has something to do with free 
speech, but I'm willing to accept that you view the kernel source as a kind of
podium.

> > I really don't see how changing out the files for a url qualifies as
> > the "worst way" of addressing the issue.  If Larry unretracts his offer
> > to host the files - and I fully expect he will do that after some period
> > of indulging in his wounded bird act - then by definition the documentation
> > will always be available exactly when and where needed.  Is there *anybody*
> > here who'd have further license-related complaints about Bitkeeper if that
> > were done?  (Speak or forever hold your peace.)
> 
> First, I can host the doc.  And will, if there is justification.
> I do not see a justification.  Larry is irrelevant.

To this discussion?  Debatable.  I'll go with you on that for now though, and
see where it leads.

> Second, I guarantee that license-related complaints about BitKeeper will
> continue to exist, regardless of the doc's location.  Moving the doc
> does absolutely nothing to assauge bad feelings about the BK license.

It would for me, others mileage may vary.

-- 
Daniel
