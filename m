Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262175AbSJNVu0>; Mon, 14 Oct 2002 17:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVu0>; Mon, 14 Oct 2002 17:50:26 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:29881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262175AbSJNVuZ>; Mon, 14 Oct 2002 17:50:25 -0400
Date: Mon, 14 Oct 2002 16:55:34 -0500
From: Shawn <core@enodev.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Christoph Hellwig <hch@infradead.org>, Shawn <core@enodev.com>,
       Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014165534.C28737@q.mn.rr.com>
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <20021014092048.A27417@q.mn.rr.com> <20021014172137.D19897@infradead.org> <200210142348.29628.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210142348.29628.oliver@neukum.name>; from oliver@neukum.name on Mon, Oct 14, 2002 at 11:48:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14, Oliver Neukum said something like:
> Am Montag, 14. Oktober 2002 18:21 schrieb Christoph Hellwig:
> > On Mon, Oct 14, 2002 at 09:20:48AM -0500, Shawn wrote:
> > > Having said all that, given that your premises are true regarding the
> > > code design problems you have with EVMS, you have a valid point about
> > > including it in mainline. The question is, is this good enough to ignore
> > > having a logical device management system?!?
> >
> > It is not good enough to ignore it.  It is good enough to postpone
> > integration for 2.7.
> 
> No, that is not an option. Either evms or lvm2 it must be.
> Switching later might be difficult. So it has to be decided
> quite soon.

I know this has the potential of being an unfortunate situation for
many, but edicts do not help.

If neither LVM2 or EVMS are truly ready, no one is beholden to anyone
else as to anything's inclusion in mainline.

It's a matter of marketing so say whether Linux has volume management.
If all the distros have LVM in some form, then "Linux has an LVM". So,
no one can really say "Linux doesn't have an LVM so it's not enterprise
ready.

It's just really inconvenient for those who
 1. want to run a devel kernel
 2. want to run an LVM
 3. want to be really really up-to-date
because we (the testers) have to do a lot of the forward porting grunt
work fixing all the patch rejects and compile errors that inevitably
come.

--
Shawn Leas
core@enodev.com

I have a hobby...I have the world's largest collection of sea shells.
I keep it scattered on beaches all over the world.  Maybe you've seen
some of it... 
						-- Stephen Wright
