Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSDVRlE>; Mon, 22 Apr 2002 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSDVRlD>; Mon, 22 Apr 2002 13:41:03 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:56774 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314325AbSDVRlC>;
	Mon, 22 Apr 2002 13:41:02 -0400
Date: Mon, 22 Apr 2002 13:40:59 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020422134059.B11216@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204211158160.30929-100000@twinlark.arctic.org> <E16zIi9-0001Fs-00@starship> <20020422130328.C6638@havoc.gtf.org> <E16zL7i-0001I2-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 07:27:37PM +0200, Daniel Phillips wrote:
>   1) It would be equally as useful as a URL

Maybe 5% less useful or so.  There are reasons we move other
(non-controversial) docs into the kernel source.  100% of these docs can
be URLs.

>   2) It would not consume download bandwidth

This is a silly argument that dean gaudet dismembered.  It's 12K
compressed and not your main argument at all.


>   3) It would show some sensitivity to the concerns of those who are
>      uncomfortable with the license.

I agree.

So, I believe points #1 and #2 are silly, and #3 is your core argument.

And I agree that it would show sensitivity towards those people who
dislike the BK license.

That said, I still think removing the doc is a hideously wrong thing
to do.  I see the action of BK doc removal as encouraging some strict
notion of what we can and cannot discuss, inside the kernel sources.
_That_ is the free speech aspect.

I see enforcing a strict notion of acceptable speech in the kernel
sources as a very bad thing for the Linux project.

I'm not asking you to agree -- but do you even understand my viewpoint here?


> > There is no dispute that the doc is useful, only dispute with certain
> > beliefs.  Disagreement is fine... encouraged, even.  But that's a
> > poor justification to remove the doc from the tree.
> > 
> > I hear your point, I really do.  I just feel very strongly that
> > removing the BK docs from the tree is the worst way to go about
> > supporting this point of view.
> 
> I really don't see how changing out the files for a url qualifies as
> the "worst way" of addressing the issue.  If Larry unretracts his offer
> to host the files - and I fully expect he will do that after some period
> of indulging in his wounded bird act - then by definition the documentation
> will always be available exactly when and where needed.  Is there *anybody*
> here who'd have further license-related complaints about Bitkeeper if that
> were done?  (Speak or forever hold your peace.)

First, I can host the doc.  And will, if there is justification.
I do not see a justification.  Larry is irrelevant.

Second, I guarantee that license-related complaints about BitKeeper will
continue to exist, regardless of the doc's location.  Moving the doc
does absolutely nothing to assauge bad feelings about the BK license.

	Jeff



