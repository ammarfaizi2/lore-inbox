Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131053AbQKACFN>; Tue, 31 Oct 2000 21:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131070AbQKACFE>; Tue, 31 Oct 2000 21:05:04 -0500
Received: from fw.SuSE.com ([202.58.118.35]:23538 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S131053AbQKACEv>;
	Tue, 31 Oct 2000 21:04:51 -0500
Date: Tue, 31 Oct 2000 19:10:43 -0800
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Jakma <paul@clubi.ie>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: scsi-cdrom lockup and ide-scsi problem (both EFS related)
Message-ID: <20001031191043.C11727@suse.de>
In-Reply-To: <20001031183357.B11727@suse.de> <E13qn6S-00001i-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13qn6S-00001i-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Nov 01, 2000 at 01:54:11AM +0000
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01 2000, Alan Cox wrote:
> > It's untested behaviour at this point, all bets are off. It
> > hasn't oopses here though...
> 
> Not just CD either. SCSI disk has the same problem in 2.4 but not 2.2

Disk too? I guess Eric broke more than he bargained for :)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
