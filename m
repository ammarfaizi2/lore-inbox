Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271592AbRIJTAd>; Mon, 10 Sep 2001 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271597AbRIJTAX>; Mon, 10 Sep 2001 15:00:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14866 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271592AbRIJTAL>; Mon, 10 Sep 2001 15:00:11 -0400
Date: Mon, 10 Sep 2001 21:01:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910210116.B715@athlon.random>
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de> <20010910200344.C714@athlon.random> <20010910204928.A22889@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010910204928.A22889@caldera.de>; from hch@caldera.de on Mon, Sep 10, 2001 at 08:49:28PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 08:49:28PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 10, 2001 at 08:03:44PM +0200, Andrea Arcangeli wrote:
> > On Mon, Sep 10, 2001 at 07:41:58PM +0200, Christoph Hellwig wrote:
> > > In article <20010910175416.A714@athlon.random> you wrote:
> > > > Only in 2.4.10pre4aa1: 00_paride-max_sectors-1
> > > > Only in 2.4.10pre7aa1: 00_paride-max_sectors-2
> > > >
> > > > 	Rediffed (also noticed the gendisk list changes deleted too much stuff
> > > > 	here so resurrected it).
> > > 
> > > Do you plan to submit the max_sectors changes to Linus & Alan?
> > > Otherwise I will do as they seem to be needed for reliable operation.
> > 
> > agreed, Linus, here it is ready for merging into mainline:
> 
> I think the sd part is much more interesting for most users..

more interesting for most users certainly ;), but it's not needed for
reliable operations so I thought you were talking about the paride
fixes (also you quoted the 00_paride-... filename).

Andrea
