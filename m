Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRDPUxi>; Mon, 16 Apr 2001 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDPUxZ>; Mon, 16 Apr 2001 16:53:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3856 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132072AbRDPUxO>;
	Mon, 16 Apr 2001 16:53:14 -0400
Date: Mon, 16 Apr 2001 22:53:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Eure <ieure@insynq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010416225300.R9539@suse.de>
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com> <20010409095607.A432@suse.de> <15060.43709.340915.563107@pyramid.insynq.com> <20010413145614.E13621@suse.de> <15067.6955.346718.263498@pyramid.insynq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15067.6955.346718.263498@pyramid.insynq.com>; from ieure@insynq.com on Mon, Apr 16, 2001 at 09:17:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16 2001, Ian Eure wrote:
> Jens Axboe writes:
>  > On Wed, Apr 11 2001, Ian Eure wrote:
>  > > i get this message when it panics:
>  > > 
>  > > -- snip --
>  > > loop: setting 534781920 bs for 07:86
>  > > Kernel panic: Invalid blocksize passed to set_blocksize
>  > > -- snip --
>  > 
>  > Ahm, how are you setting your loop device up? The above is completely
>  > bogus.
>  > 
> `mount foo /mnt2 -oloop,dev'

Majorly strange, will take a look.

-- 
Jens Axboe

