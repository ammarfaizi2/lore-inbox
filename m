Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283543AbRK3HlD>; Fri, 30 Nov 2001 02:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283540AbRK3Hky>; Fri, 30 Nov 2001 02:40:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21522 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283543AbRK3Hkm>;
	Fri, 30 Nov 2001 02:40:42 -0500
Date: Fri, 30 Nov 2001 08:40:15 +0100
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Stuff that needs fixing in 2.5.1-pre4
Message-ID: <20011130084015.H16796@suse.de>
In-Reply-To: <3C06F3A5.D407607A@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C06F3A5.D407607A@delusion.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Udo A. Steinberg wrote:
> 
> Hi all,
> 
> Below a few things that should probably be fixed in the current 2.5. tree.

Make the get_block long argument for block a sector_t. Once you have
that warning free, send on the fix.

-- 
Jens Axboe

