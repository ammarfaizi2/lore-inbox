Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135669AbRAMCEh>; Fri, 12 Jan 2001 21:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135819AbRAMCE0>; Fri, 12 Jan 2001 21:04:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33037 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135669AbRAMCEO>;
	Fri, 12 Jan 2001 21:04:14 -0500
Date: Sat, 13 Jan 2001 03:04:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Jordan <jordang@pcc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can't build small enough zImage for floppy
Message-ID: <20010113030406.C22380@suse.de>
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5F7BA7.B2FF852B@pcc.net>; from jordang@pcc.net on Fri, Jan 12, 2001 at 03:48:23PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12 2001, Jordan wrote:
> 1st, the Sony Vaio Z505HS appears to be an example of a machine which
> will not boot a bzImage correctly, compaining about the compression
> format.

I have this exact model too, and it boots bzImage just fine. In fact,
I've never booted anything but bzImage's on it. Maybe a BIOS issue
that a fw upgrade will fix?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
