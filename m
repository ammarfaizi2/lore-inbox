Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282133AbRLDBpv>; Mon, 3 Dec 2001 20:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284614AbRLDAOK>; Mon, 3 Dec 2001 19:14:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285135AbRLCUwX>;
	Mon, 3 Dec 2001 15:52:23 -0500
Date: Mon, 3 Dec 2001 21:52:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
Message-ID: <20011203215202.G5176@suse.de>
In-Reply-To: <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu> <E16AaCR-0003wy-00@the-village.bc.nu> <200112021802.fB2I2iE10476@vindaloo.ras.ucalgary.ca> <20011203135842.A5176@suse.de> <200112031906.fB3J6X323874@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200112031906.fB3J6X323874@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03 2001, Richard Gooch wrote:
> Jens Axboe writes:
> > On Sun, Dec 02 2001, Richard Gooch wrote:
> > > And 2.5 isn't going to get a lot of testing until the breakage caused
> > > by the bio changes is fixed. At the moment, I can't even test it
> > > myself.
> > 
> > I'll just go read your bug rapport and fix it right up.
> 
> It wasn't meant as a criticism of the changes. I'm glad to see someone
> working on fixing the bio layer. It's just not ready for widespread
> testing yet (crude measurement: if it breaks for me, it's not ready
> for the masses ;-). Once I surface from this round of devfs cleanups,
> I'll pause for breath and try again with 2.5. If I still have
> problems, I'll let you know.

No seriously, I want to know if something is broken so it can get fixed.
bio core is indeed stable, if something breaks it's drivers. And they
need fixing right away.

At least until I break every single block driver out there again in a
few days. And no, I'm not kidding.

-- 
Jens Axboe

