Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSKERUF>; Tue, 5 Nov 2002 12:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264987AbSKERUF>; Tue, 5 Nov 2002 12:20:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48790 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264986AbSKERTp>;
	Tue, 5 Nov 2002 12:19:45 -0500
Date: Tue, 5 Nov 2002 18:26:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105172617.GC1830@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <1036517201.5601.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036517201.5601.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Arjan van de Ven wrote:
> On Tue, 2002-11-05 at 18:14, Jens Axboe wrote:
> 
> > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > 641:CONFIG_NFSD_V4=y
> > axboe@burns:[.]linux-2.5-deadline-rbtree $ vi .config
> > axboe@burns:[.]linux-2.5-deadline-rbtree $ grep CONFIG_NFSD_V4 < .config
> > 641:CONFIG_NFSD_V4=n
> 
> =n never worked...

You're wrong, it's always worked. I've never used anything but that.

> # CONFIG_NFSD_V4 is not set

Come on, you really expect me to type the whole damn thing? That's
silly.

-- 
Jens Axboe

