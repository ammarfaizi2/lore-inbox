Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3Xbg>; Thu, 30 Nov 2000 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQK3Xb0>; Thu, 30 Nov 2000 18:31:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29966 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129257AbQK3XbQ>;
	Thu, 30 Nov 2000 18:31:16 -0500
Date: Fri, 1 Dec 2000 00:00:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Pries <PriesRx@hlyw.com>
Cc: Glen Gerber <GlenG.CORP.HLYW@hlyw.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Correct cdrom.h comments.
Message-ID: <20001201000048.C16713@suse.de>
In-Reply-To: <sa26679d.082@hlyw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sa26679d.082@hlyw.com>; from PriesRx@hlyw.com on Thu, Nov 30, 2000 at 02:43:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30 2000, Richard Pries wrote:
> Jens,
> 
> The following patch corrects the comments in cdrom.h for CDROMREADRAW,
> CDROMREADMODE1, and CDROMREADMODE2 that erroneously refer to the
> cdrom_read structure.  With this patch, they refer to the cdrom_msf
> structure.

Thank you, applied.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
