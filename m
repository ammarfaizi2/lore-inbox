Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287514AbRLaNSQ>; Mon, 31 Dec 2001 08:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287512AbRLaNR4>; Mon, 31 Dec 2001 08:17:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287509AbRLaNRq>;
	Mon, 31 Dec 2001 08:17:46 -0500
Date: Mon, 31 Dec 2001 14:17:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: merge in progress.
Message-ID: <20011231141732.G7130@suse.de>
In-Reply-To: <20011231140455.F7130@suse.de> <E16L2Nu-000530-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16L2Nu-000530-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31 2001, Alan Cox wrote:
> > On Mon, Dec 31 2001, Alan Cox wrote:
> > > > Things unlikely to merge yet.
> > > > o  Alans aacraid driver (not bio aware)
> > > 
> > > Thats fine. I don't plan to worry about that until 2.5 is a lot more stable.
> > 
> > I'm assuming you mean stable wrt code base changes, otherwise I'd like
> > to hear about any instability of the kernel wrt bio.
> 
> Until I am sure the block I/O layer is totally stable and the changes to
> both it and the scsi layer are complete.

Fair enough

-- 
Jens Axboe

