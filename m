Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVI0PmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVI0PmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVI0PmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:42:08 -0400
Received: from serv01.siteground.net ([70.85.91.68]:16273 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964977AbVI0PmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:42:07 -0400
Date: Tue, 27 Sep 2005 08:42:01 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050927154201.GD3822@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de> <20050907192747.GC3769@localhost.localdomain> <20050907193422.GS4785@suse.de> <58cb370e050927063674bb47a7@mail.gmail.com> <20050927152026.GC3822@localhost.localdomain> <20050927152641.GF2811@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927152641.GF2811@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 05:26:42PM +0200, Jens Axboe wrote:
> On Tue, Sep 27 2005, Ravikiran G Thirumalai wrote:
> 
> You should run it eg 10 times on each kernel to get a feel for the
> variance of the results. Were you testing 2 or 4 disks?
> 

Yes, I was planning to do that,  We were testing with 2 disks.

>...
> I take it the numbers posted were for DMA enabled on all disks?

Yes.

Thanks,
Kiran

