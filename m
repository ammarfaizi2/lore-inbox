Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132884AbRDPIuI>; Mon, 16 Apr 2001 04:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132889AbRDPIt7>; Mon, 16 Apr 2001 04:49:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28940 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132884AbRDPItu>;
	Mon, 16 Apr 2001 04:49:50 -0400
Date: Mon, 16 Apr 2001 10:49:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Arthur Pedyczak <arthur-p@home.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010416104936.B9539@suse.de>
In-Reply-To: <3AD7EE80.5AADA578@mandrakesoft.com> <Pine.LNX.4.33.0104152058210.1129-100000@cs865114-a.amp.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0104152058210.1129-100000@cs865114-a.amp.dhs.org>; from arthur-p@home.com on Sun, Apr 15, 2001 at 09:08:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15 2001, Arthur Pedyczak wrote:
> On Sat, 14 Apr 2001, Jeff Garzik wrote:
> 
> > Can you try 2.4.4-pre3?
> > ftp://ftp.us.kernel.org/pub/linux/kernel/testing/
> >
> I am testing loop behaviour in 2.4.3 and 3.4.4p3. I have noticed something
> disturbing:
> 
> I can mount the same file on the same mountpoint more than once. If I
> mount a file twice (same file on the same mount point)

This is a 2.4 feature

-- 
Jens Axboe

