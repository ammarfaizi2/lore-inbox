Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRD1R6S>; Sat, 28 Apr 2001 13:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135544AbRD1R6I>; Sat, 28 Apr 2001 13:58:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135535AbRD1R6D>;
	Sat, 28 Apr 2001 13:58:03 -0400
Date: Sat, 28 Apr 2001 19:57:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Roman Fietze <fietze@s.netic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.[234] kernel panic, DMA Pool, CDROM Mount Failure
Message-ID: <20010428195742.C11698@suse.de>
In-Reply-To: <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0104281935560.687-100000@rfhome.fietze.de>; from fietze@s.netic.de on Sat, Apr 28, 2001 at 07:42:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28 2001, Roman Fietze wrote:
> Hello,
> 
> I reported this before and the bug still exists in 2.4.4. The problem can
> be circumvented by using drivers/scsi/sr.c from kernel 2.4.[01]. This
> "fix" did not help just me, but somebody else I had contact with on the
> net.

Is the CDROM on the 1542?

And could you include full panic info, please?

-- 
Jens Axboe

