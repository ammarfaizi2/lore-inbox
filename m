Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283324AbRK2Qza>; Thu, 29 Nov 2001 11:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283322AbRK2QzU>; Thu, 29 Nov 2001 11:55:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50188 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283305AbRK2QzF>;
	Thu, 29 Nov 2001 11:55:05 -0500
Date: Thu, 29 Nov 2001 17:54:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 compile error in ide-scsi.o ide-scsi.c
Message-ID: <20011129175441.N10601@suse.de>
In-Reply-To: <20011128135552.204311E532@Cantor.suse.de> <20011129140517.8650E1E122@Cantor.suse.de> <20011129152310.L10601@suse.de> <20011129143538.3A4F81E128@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011129143538.3A4F81E128@Cantor.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Sebastian Dröge wrote:
> Sorry my mistake
> I've meant this patch: 
> http://kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1-pre3/bio-pre3-1.gz
> 
> So it's 2.5.1-pre3 + Alan's patch + bio-pre3-1 + the patch you've posted 
> after the 2.5.1-pre3 don't-use mail
> 
> There were no failures while patching so I think this patches are compatible 
> each other ;)

Yes sure, that's what I expected. THe part I didn't understand was the
sr-sg-1 part.

> And it works well... no data corruption, no oopses, no nothing ;)
> Later the day I'll test burning a CD

Good

-- 
Jens Axboe

