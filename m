Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSC0W3m>; Wed, 27 Mar 2002 17:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293122AbSC0W3c>; Wed, 27 Mar 2002 17:29:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293119AbSC0W3Y>; Wed, 27 Mar 2002 17:29:24 -0500
Date: Wed, 27 Mar 2002 23:29:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>, Andre Hedrick <andre@linux-ide.org>,
        Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
Message-ID: <20020327222900.GO19837@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020326185238.A324@toy.ucw.cz> <E16qM41-0006HG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > You can paint a goose yellow and call it a duck, but it is still a goose.
> > > The electrical/electronic interface will kill you!
> > 
> > USB mass storage is not SCSI (in some cases), either. [Ouch, and some
> > usb-storage devices *are* IDE.]
> > 
> > So it makes sense to view IDE as very odd SCSI controllers.
> 
> IDE is very different. Its like calling NFS Netware. The upper layer
> behaviour is fairly similar, and both ATAPI and USB mass storage is SCSI
> alike (note if its not SCSI like its not USB mass storage its something else
> eg a vendor specific driver).

I have seen USB mass storage devices with ide connector on them, so it
is certainly possible to translate between scsi and ide. If it makes
sense from performance standpoint.... I don't know.
						Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
