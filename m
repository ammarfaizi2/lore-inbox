Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290754AbSAaAM0>; Wed, 30 Jan 2002 19:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290757AbSAaAMQ>; Wed, 30 Jan 2002 19:12:16 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52491
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290754AbSAaAMH>; Wed, 30 Jan 2002 19:12:07 -0500
Date: Wed, 30 Jan 2002 16:03:50 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130234847.GA25577@codepoet.org>
Message-ID: <Pine.LNX.4.10.10201301602440.16570-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Erik Andersen wrote:

> On Wed Jan 30, 2002 at 11:06:04PM +0000, Alan Cox wrote:
> > > bravery.  That pile of dung does not need a "small-stuff"
> > > maintainer.  It needs to be forcefully ejected and replaced with
> > > extreme prejudice.  It is amazing that ancient stuff works as
> > > well as it does...
> > 
> > A lot of the apparently really ugly drivers turned out to be very good code
> > hiding under 10 years of history and core code changes and
> > assumptions. See the NCR5380 stuff I've now all done (in 2.4.18pre) - dont 
> > use 2.5.* NCR5380 it'll probably corrupt your system if it doesn't just die
> > or hang - Linus apparently merged untested stuff to the old broken driver.
> 
> This is in the latest -ac kernels?  Cool, I'll go take a close
> look.  I'm very anxious to see a SCSI layer that doesn't suck
> get put in place,

Given me another development tree of time to create one and it will be a
done deal, but I have enough to clean up in what is started now.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

