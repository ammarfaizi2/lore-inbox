Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQKTULw>; Mon, 20 Nov 2000 15:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQKTULe>; Mon, 20 Nov 2000 15:11:34 -0500
Received: from [194.73.73.138] ([194.73.73.138]:31878 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129831AbQKTULU>;
	Mon, 20 Nov 2000 15:11:20 -0500
Date: Mon, 20 Nov 2000 19:41:11 +0000 (GMT)
From: davej@suse.de
To: "Michael J. Dikkema" <mjd@moot.mb.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Abit VP6 HPT370 support?
In-Reply-To: <Pine.LNX.4.21.0011201227001.3379-100000@sliver.moot.mb.ca>
Message-ID: <Pine.LNX.4.21.0011201930120.2645-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, Michael J. Dikkema wrote:

> Does Linux 2.4pre support the raid controller on the abit vp6? The kernel
> says it supports the 370, but it doesn't mention raid. I was confused as
> to if there was a difference or not.

I have a standalone card with the HPT370 chipset doing RAID fine.
Or at least did until one of the drives died within an hour of using it.
This was drive failure, not the card though. Whilst it was working,
it seemed to be working fine. :)

> Also, OT, does anyone know if the controller is managed through hardware
> or through software?

The packaging / manual for this card suggests that its hardware based.
If it isn't, it's extremely misleading.

regards,

Dave.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
