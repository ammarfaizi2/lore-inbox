Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263536AbRFFQUS>; Wed, 6 Jun 2001 12:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263539AbRFFQUI>; Wed, 6 Jun 2001 12:20:08 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59526 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263536AbRFFQUC>; Wed, 6 Jun 2001 12:20:02 -0400
Date: Wed, 6 Jun 2001 10:19:45 -0600
Message-Id: <200106061619.f56GJjw15740@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Christian =?iso-8859-1?Q?Borntr=E4ger?=" 
	<linux-kernel@borntraeger.net>,
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Requirement: swap = RAM x 2.5 ??
In-Reply-To: <3B1E572B.1CEEF41B@mandrakesoft.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<991815578.30689.1.camel@nomade>
	<20010606095431.C15199@dev.sportingbet.com>
	<0106061316300A.00553@starship>
	<200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
	<000701c0ee9f$515fd6a0$3303a8c0@einstein>
	<3B1E52FC.C17C921F@mandrakesoft.com>
	<200106061612.f56GCbA14901@vindaloo.ras.ucalgary.ca>
	<3B1E572B.1CEEF41B@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Richard Gooch wrote:
> > 
> > Jeff Garzik writes:
> > >
> > > I'm sorry but this is a regression, plain and simple.
> > >
> > > Previous versons of Linux have worked great on diskless workstations
> > > with NO swap.
> > >
> > > Swap is "extra space to be used if we have it" and nothing else.
> > 
> > Sure. But Linux still works without swap. It's just that if you *do*
> > have swap, it works best with 2* RAM.
> 
> Yes, but that's not the point of the discussion.  Currently 2*RAM is
> more of a requirement than a recommendation.

Um, do you mean "2*RAM is required, always", or "2*RAM or more swap is
required if swap != 0"?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
