Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKAMqa>; Wed, 1 Nov 2000 07:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130619AbQKAMqU>; Wed, 1 Nov 2000 07:46:20 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35088 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129055AbQKAMqJ>; Wed, 1 Nov 2000 07:46:09 -0500
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
To: axboe@suse.de (Jens Axboe)
Date: Wed, 1 Nov 2000 12:47:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), paul@clubi.ie (Paul Jakma),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20001031191043.C11727@suse.de> from "Jens Axboe" at Oct 31, 2000 07:10:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qxIX-0000OZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 01 2000, Alan Cox wrote:
> > > It's untested behaviour at this point, all bets are off. It
> > > hasn't oopses here though...
> > 
> > Not just CD either. SCSI disk has the same problem in 2.4 but not 2.2
> 
> Disk too? I guess Eric broke more than he bargained for :)

Magneto optical disks are 2K block size with 512 byte chunked MSDOS fs on them

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
