Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbRLJOHj>; Mon, 10 Dec 2001 09:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286268AbRLJOHU>; Mon, 10 Dec 2001 09:07:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65288 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286261AbRLJOHO>;
	Mon, 10 Dec 2001 09:07:14 -0500
Date: Mon, 10 Dec 2001 15:07:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephen Cameron <smcameron@yahoo.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] cpqfc driver for 2.5.1-pre5 tree
Message-ID: <20011210140701.GF5095@suse.de>
In-Reply-To: <20011206164206.58598.qmail@web12304.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011206164206.58598.qmail@web12304.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06 2001, Stephen Cameron wrote:
> 
> Hi folks, 
> 
> Here is a patch for the cpqfc driver to make it compile and run in the 2.5.1-pre5
> tree.  I feel obligated to mention that I did see messages along the lines
> of "running *really* low on DMA buffers" coming from scsi_merge.c, but
> Jens told me not to worry about that, so here's the patch.  
> 
> It gets rid of the io_request_lock dependency, and silences a few
> annoying printks that the driver has been spewing on startup.

Thanks!

-- 
Jens Axboe

