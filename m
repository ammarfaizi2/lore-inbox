Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265146AbSKESIL>; Tue, 5 Nov 2002 13:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265150AbSKESIL>; Tue, 5 Nov 2002 13:08:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265146AbSKESIJ>;
	Tue, 5 Nov 2002 13:08:09 -0500
Date: Tue, 5 Nov 2002 19:14:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105181431.GB3515@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain> <20021105172617.GC1830@suse.de> <1036520436.4791.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036520436.4791.114.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Alan Cox wrote:
> On Tue, 2002-11-05 at 17:26, Jens Axboe wrote:
> > You're wrong, it's always worked. I've never used anything but that.
> > 
> > > # CONFIG_NFSD_V4 is not set
> > 
> > Come on, you really expect me to type the whole damn thing? That's
> > silly.
> 
> So write a sed script to turn n into "is not set" or submit a change to
> cover it. Its luck =n ever did what you expected though.

5 years of luck isn't bad, I ought to start gambling.

I'll write the script, just a damn shame that this feature is gone now.
.config editing is less powerful now.

-- 
Jens Axboe

