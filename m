Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbSJNWr5>; Mon, 14 Oct 2002 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSJNWr4>; Mon, 14 Oct 2002 18:47:56 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:61115 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262256AbSJNWrz>; Mon, 14 Oct 2002 18:47:55 -0400
Date: Mon, 14 Oct 2002 17:53:04 -0500
From: Shawn <core@enodev.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Shawn <core@enodev.com>, Christoph Hellwig <hch@infradead.org>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014175304.A28906@q.mn.rr.com>
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <200210142348.29628.oliver@neukum.name> <20021014165534.C28737@q.mn.rr.com> <200210150035.14923.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210150035.14923.oliver@neukum.name>; from oliver@neukum.name on Tue, Oct 15, 2002 at 12:35:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14, Oliver Neukum said something like:
> 
> > If neither LVM2 or EVMS are truly ready, no one is beholden to anyone
> > else as to anything's inclusion in mainline.
> >
> > It's a matter of marketing so say whether Linux has volume management.
> > If all the distros have LVM in some form, then "Linux has an LVM". So,
> > no one can really say "Linux doesn't have an LVM so it's not enterprise
> > ready.
> 
> This is not true. Something has to be in the mainline, so that bugs can
> be fixed. This too important to be left to distributors.

As I said before, edicts help no one. I appreciate your sentiment, and
to some degree share it, but you have to take a non-cheerleader look at
things like this.

> Besides people who compile their own kernels are not that unimportant.

No one is saying that. No one is even saying that mainline inclusion
isn't extremely beneficial to EVMS or DM. The question isn't whether DM
or EVMS would be impacted more positively if it were included. The
question is whether mainline would be better off including them, and not
the other way around.

Also, let me define the phrase "better off" to mean "better off W.R.T.
design, architecture, overall code quality, abstractions in the right
place, etc etc", and not to mean politically, as in, more users.

Honestly though, if you aren't able to do the work it takes to be a 3rd
party patch tester, it's less likely you can properly test or submit
proper bug reports in the first place.

--
Shawn Leas
core@enodev.com

I had some eyeglasses.  I was walking down the street when
suddenly the prescription ran out.
						-- Stephen Wright
