Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbRBHO5J>; Thu, 8 Feb 2001 09:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130927AbRBHO47>; Thu, 8 Feb 2001 09:56:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:526 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129486AbRBHO4u>;
	Thu, 8 Feb 2001 09:56:50 -0500
Date: Thu, 8 Feb 2001 15:56:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt_Domsch@Dell.com, jason@heymax.com, linux-kernel@vger.kernel.org,
        gandalf@winds.org
Subject: Re: aacraid 2.4.0 kernel
Message-ID: <20010208155630.C3262@suse.de>
In-Reply-To: <20010208041814.I27027@suse.de> <E14QmDJ-0002pJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14QmDJ-0002pJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 08, 2001 at 08:13:58AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08 2001, Alan Cox wrote:
> > total request sizes. I would rather fix this limitation then, and
> > would also be interested to know if any of the (older) SCSI drivers
> > have such limitations too.
> 
> And some new ones. One of my i2o scsi controllers has that problem. 

Ok thanks, I'll do the patch then.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
