Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284956AbRLKKcl>; Tue, 11 Dec 2001 05:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284958AbRLKKca>; Tue, 11 Dec 2001 05:32:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7695 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284956AbRLKKc0>;
	Tue, 11 Dec 2001 05:32:26 -0500
Date: Tue, 11 Dec 2001 11:32:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre9 -- Unresolved symbols in scsi_mod.o
Message-ID: <20011211103219.GJ13498@suse.de>
In-Reply-To: <Pine.LNX.4.33.0112102333310.9791-100000@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112102333310.9791-100000@stomata.megapathdsl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10 2001, Miles Lane wrote:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.1-pre9/kernel/drivers/scsi/scsi_mod.o
> depmod: 	blk_contig_segment
> depmod: 	bio_hw_segments
> depmod: 	blk_queue_segment_boundary

Will export.

-- 
Jens Axboe

