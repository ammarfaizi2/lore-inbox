Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTKFTzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTKFTzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:55:50 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:32975 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263812AbTKFTzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:55:44 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Date: Thu, 6 Nov 2003 14:55:41 -0500
User-Agent: KMail/1.5.1
References: <3FA69CDF.5070908@gmx.de> <20031105101207.GI1477@suse.de> <boe6in$f4q$1@gatekeeper.tmr.com>
In-Reply-To: <boe6in$f4q$1@gatekeeper.tmr.com>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061455.41642.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.62.77] at Thu, 6 Nov 2003 13:55:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 November 2003 14:14, bill davidsen wrote:
>In article <20031105101207.GI1477@suse.de>, Jens Axboe  
<axboe@suse.de> wrote:
>| k3b is probably still going through ide-scsi which you must not.
>| It would be interesting if you could try without ide-scsi and use
>| cdrecord manually (maybe someone more knowledgable on k3b can
>| common on whether they support 2.6 or not). 2.6 will be a lot
>| faster than 2.4.
>
>I'm not sure what you mean by faster, burning runs at device limited
>speed in CPU time in the  less than 1% range if you remember to
> enable DMA. The last time I looked DMA didn't work in either kernel
> if write size was not a multiple of 1k, (or 2k?) has that changed?
>
>I'm not sure what you meant by faster, so don't think I'm
> disagreeing with you.

As in it actually said it was burning at 12x, and could do a 650 meg 
iso in a bit over 6 minutes including fixating.  Thats about 3 to 4 
minutes faster than its ever been.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

