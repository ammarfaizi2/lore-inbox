Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbRLaNLg>; Mon, 31 Dec 2001 08:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287511AbRLaNL1>; Mon, 31 Dec 2001 08:11:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287512AbRLaNLN>; Mon, 31 Dec 2001 08:11:13 -0500
Subject: Re: merge in progress.
To: axboe@suse.de (Jens Axboe)
Date: Mon, 31 Dec 2001 13:21:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20011231140455.F7130@suse.de> from "Jens Axboe" at Dec 31, 2001 02:04:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2Nu-000530-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Dec 31 2001, Alan Cox wrote:
> > > Things unlikely to merge yet.
> > > o  Alans aacraid driver (not bio aware)
> > 
> > Thats fine. I don't plan to worry about that until 2.5 is a lot more stable.
> 
> I'm assuming you mean stable wrt code base changes, otherwise I'd like
> to hear about any instability of the kernel wrt bio.

Until I am sure the block I/O layer is totally stable and the changes to
both it and the scsi layer are complete.
