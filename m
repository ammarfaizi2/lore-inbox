Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131041AbQKABxT>; Tue, 31 Oct 2000 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131053AbQKABxJ>; Tue, 31 Oct 2000 20:53:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2685 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131041AbQKABxC>; Tue, 31 Oct 2000 20:53:02 -0500
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
To: axboe@suse.de (Jens Axboe)
Date: Wed, 1 Nov 2000 01:54:11 +0000 (GMT)
Cc: paul@clubi.ie (Paul Jakma), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20001031183357.B11727@suse.de> from "Jens Axboe" at Oct 31, 2000 06:33:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qn6S-00001i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > correctly with SCSI CD-ROM (it's even on Ted's list).
> > 
> > doesn't work is one thing.. but an instant lockup? that's a bit
> > unfriendly. :)
> 
> It's untested behaviour at this point, all bets are off. It
> hasn't oopses here though...

Not just CD either. SCSI disk has the same problem in 2.4 but not 2.2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
