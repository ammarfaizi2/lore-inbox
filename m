Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRDPQj3>; Mon, 16 Apr 2001 12:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDPQjW>; Mon, 16 Apr 2001 12:39:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32270 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131508AbRDPQif>;
	Mon, 16 Apr 2001 12:38:35 -0400
Date: Mon, 16 Apr 2001 18:38:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Mircea Damian <dmircea@kappa.ro>
Cc: Alexander Viro <viro@math.psu.edu>, Arthur Pedyczak <arthur-p@home.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010416183812.I9539@suse.de>
In-Reply-To: <20010416104936.B9539@suse.de> <Pine.GSO.4.21.0104160527400.3095-100000@weyl.math.psu.edu> <20010416131023.A19844@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010416131023.A19844@linux.kappa.ro>; from dmircea@kappa.ro on Mon, Apr 16, 2001 at 01:10:23PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16 2001, Mircea Damian wrote:
> But the guy said:
> "
> > disappers from cat /proc/mounts output, but the module 'loop' shows as
> > busy and cannot be removed even though there are no more loop mounts.
> "
> 
> So he has no loop mounts and he can not remove the module. This is a bug!

Ah indeed, I'll take a look.

-- 
Jens Axboe

