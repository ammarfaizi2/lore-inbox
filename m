Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264949AbSKESKE>; Tue, 5 Nov 2002 13:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264969AbSKESJ1>; Tue, 5 Nov 2002 13:09:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48283 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264949AbSKESJL>;
	Tue, 5 Nov 2002 13:09:11 -0500
Date: Tue, 5 Nov 2002 19:15:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105181533.GC3515@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <3DC7FD95.5000903@pobox.com> <20021105172110.GB1830@suse.de> <20021105181403.GG17573@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105181403.GG17573@nic1-pc.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Joel Becker wrote:
> On Tue, Nov 05, 2002 at 06:21:10PM +0100, Jens Axboe wrote:
> > > '=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...
> > 
> > Why is that wrong? It worked before.
> 
> 	I've run into kernels where '=n' didn't work.  The old-skool

Never ever had a problem with it, and I've compiled pretty much every
single kernel in the last handful of kernel cycles.

> canonical answer was "# CONFIG_FOO is not set", and that worked reliably
> in <2.5

Less handy, though.

-- 
Jens Axboe

