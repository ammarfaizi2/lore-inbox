Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281852AbRLDBpy>; Mon, 3 Dec 2001 20:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282080AbRLDANr>; Mon, 3 Dec 2001 19:13:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28096 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284981AbRLCTGm>; Mon, 3 Dec 2001 14:06:42 -0500
Date: Mon, 3 Dec 2001 12:06:33 -0700
Message-Id: <200112031906.fB3J6X323874@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <20011203135842.A5176@suse.de>
In-Reply-To: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu>
	<E16AaCR-0003wy-00@the-village.bc.nu>
	<200112021802.fB2I2iE10476@vindaloo.ras.ucalgary.ca>
	<20011203135842.A5176@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
> On Sun, Dec 02 2001, Richard Gooch wrote:
> > And 2.5 isn't going to get a lot of testing until the breakage caused
> > by the bio changes is fixed. At the moment, I can't even test it
> > myself.
> 
> I'll just go read your bug rapport and fix it right up.

It wasn't meant as a criticism of the changes. I'm glad to see someone
working on fixing the bio layer. It's just not ready for widespread
testing yet (crude measurement: if it breaks for me, it's not ready
for the masses ;-). Once I surface from this round of devfs cleanups,
I'll pause for breath and try again with 2.5. If I still have
problems, I'll let you know.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
