Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145097AbRA2Dxc>; Sun, 28 Jan 2001 22:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145104AbRA2DxM>; Sun, 28 Jan 2001 22:53:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12557 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S145097AbRA2DxG>;
	Sun, 28 Jan 2001 22:53:06 -0500
Date: Mon, 29 Jan 2001 04:53:01 +0100
From: Jens Axboe <axboe@suse.de>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: D state after applying ps hang patch
Message-ID: <20010129045301.D15679@suse.de>
In-Reply-To: <3A74B6AE.C179050B@linux.com> <20010129013145.G12772@suse.de> <3A74DCEE.7FBC1879@linux.com> <20010129045001.C15679@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010129045001.C15679@suse.de>; from axboe@suse.de on Mon, Jan 29, 2001 at 04:50:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Jens Axboe wrote:
> Try this ll_rw_blk.c change instead, on top of pre11. Include
> Linus' mm fixes of course.

On top of ac12 I mean, pre11 already has a different (but functional)
change.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
