Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283179AbRK2OXw>; Thu, 29 Nov 2001 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283246AbRK2OXm>; Thu, 29 Nov 2001 09:23:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:18695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283179AbRK2OXd>;
	Thu, 29 Nov 2001 09:23:33 -0500
Date: Thu, 29 Nov 2001 15:23:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Slo Mo Snail <slomosnail@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011129152310.L10601@suse.de>
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011128153718.D23858@suse.de> <20011129140517.8650E1E122@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129140517.8650E1E122@Cantor.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Slo Mo Snail wrote:
> > But wait :)
> > I'll first test 2.5.1-pre3 + Alan's Patch + your sg-sr patch + your bio
> > patch Bye
> Hmm it works :)

Just to confirm -- 2.5.1-pre3 + Alan's patch + my bio-pre3-1 patch,
right? pre3 already contains the sg-sr part.

> I'll test some more things with my CD drives ;)
> Maybe I'll find some bugs

Please do :)

-- 
Jens Axboe

