Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283050AbRK1OIA>; Wed, 28 Nov 2001 09:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283054AbRK1OHw>; Wed, 28 Nov 2001 09:07:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283050AbRK1OHk>;
	Wed, 28 Nov 2001 09:07:40 -0500
Date: Wed, 28 Nov 2001 15:07:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011128150717.C23858@suse.de>
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128145858.A23858@suse.de> <20011128140246.318A01E560@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011128140246.318A01E560@Cantor.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28 2001, Sebastian Dröge wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Mittwoch, 28. November 2001 14:58 schrieben Sie:
> > On Wed, Nov 28 2001, Sebastian Dröge wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Hi Jens,
> > > your patch doesn't work for ide-scsi
> > > I get this oops when trying to mount a CD:
> >
> > [oops in sr_scatter_pad]
> >
> > Hmm ok, and 2.5.1-pre1 works for you right?
> 
> Yes it works very well

Ok, thanks for confirming that. Going to take a look at it now.

-- 
Jens Axboe

