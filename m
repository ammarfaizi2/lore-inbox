Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287520AbRLaNFq>; Mon, 31 Dec 2001 08:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287514AbRLaNFe>; Mon, 31 Dec 2001 08:05:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287513AbRLaNFN>;
	Mon, 31 Dec 2001 08:05:13 -0500
Date: Mon, 31 Dec 2001 14:04:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: merge in progress.
Message-ID: <20011231140455.F7130@suse.de>
In-Reply-To: <20011231031506.A1537@suse.de> <E16L2F5-00050A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16L2F5-00050A-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31 2001, Alan Cox wrote:
> > Things unlikely to merge yet.
> > o  Alans aacraid driver (not bio aware)
> 
> Thats fine. I don't plan to worry about that until 2.5 is a lot more stable.

I'm assuming you mean stable wrt code base changes, otherwise I'd like
to hear about any instability of the kernel wrt bio.

-- 
Jens Axboe

