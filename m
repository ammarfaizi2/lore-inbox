Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263527AbRFFQQI>; Wed, 6 Jun 2001 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263529AbRFFQP6>; Wed, 6 Jun 2001 12:15:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34970 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263527AbRFFQPn>;
	Wed, 6 Jun 2001 12:15:43 -0400
Message-ID: <3B1E572B.1CEEF41B@mandrakesoft.com>
Date: Wed, 06 Jun 2001 12:15:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Christian =?iso-8859-1?Q?Borntr=E4ger?=" 
	<linux-kernel@borntraeger.net>,
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Requirement: swap = RAM x 2.5 ??
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
		<991815578.30689.1.camel@nomade>
		<20010606095431.C15199@dev.sportingbet.com>
		<0106061316300A.00553@starship>
		<200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
		<000701c0ee9f$515fd6a0$3303a8c0@einstein>
		<3B1E52FC.C17C921F@mandrakesoft.com> <200106061612.f56GCbA14901@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Jeff Garzik writes:
> >
> > I'm sorry but this is a regression, plain and simple.
> >
> > Previous versons of Linux have worked great on diskless workstations
> > with NO swap.
> >
> > Swap is "extra space to be used if we have it" and nothing else.
> 
> Sure. But Linux still works without swap. It's just that if you *do*
> have swap, it works best with 2* RAM.

Yes, but that's not the point of the discussion.  Currently 2*RAM is
more of a requirement than a recommendation.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
