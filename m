Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129601AbQKXVOE>; Fri, 24 Nov 2000 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129866AbQKXVNz>; Fri, 24 Nov 2000 16:13:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16645 "EHLO virtualhost.dk")
        by vger.kernel.org with ESMTP id <S129601AbQKXVNi>;
        Fri, 24 Nov 2000 16:13:38 -0500
Date: Fri, 24 Nov 2000 21:43:34 +0100
From: Jens Axboe <axboe@suse.de>
To: KELEMEN Peter <fuji@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AIC-7xxx oops
Message-ID: <20001124214334.F11366@suse.de>
In-Reply-To: <20001120165454.A15236@chiara.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001120165454.A15236@chiara.elte.hu>; from fuji@elte.hu on Mon, Nov 20, 2000 at 04:54:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20 2000, KELEMEN Peter wrote:
> Hello.
> 
> I've been experiencing SCSI-related oopsen since 2.4.0-test6.
> Couple of minutes ago I tried with test11 final, no luck still.
> When I attempt to play an audio CD using cdplay from the cdtool
> package, I'm rewarded with the following oops and cdplay
> segfaults.

Known and fixed, not submitted to Linus yet.

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test11/cd-1.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
