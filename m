Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSKESHy>; Tue, 5 Nov 2002 13:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265146AbSKESHy>; Tue, 5 Nov 2002 13:07:54 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:63471 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S265143AbSKESHx>; Tue, 5 Nov 2002 13:07:53 -0500
Date: Tue, 5 Nov 2002 10:14:04 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 vi .config ; make oldconfig not working
Message-ID: <20021105181403.GG17573@nic1-pc.us.oracle.com>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com> <20021105171409.GA1137@suse.de> <3DC7FD95.5000903@pobox.com> <20021105172110.GB1830@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105172110.GB1830@suse.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 06:21:10PM +0100, Jens Axboe wrote:
> > '=n' is wrong, that should be "# CONFIG_NFSD_V4 is not set" still...
> 
> Why is that wrong? It worked before.

	I've run into kernels where '=n' didn't work.  The old-skool
canonical answer was "# CONFIG_FOO is not set", and that worked reliably
in <2.5

Joel

-- 

 print STDOUT q
 Just another Perl hacker,
 unless $spring
	- Larry Wall

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
