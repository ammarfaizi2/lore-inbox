Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSKNS36>; Thu, 14 Nov 2002 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSKNS36>; Thu, 14 Nov 2002 13:29:58 -0500
Received: from posti3.jyu.fi ([130.234.5.32]:12967 "EHLO posti3.jyu.fi")
	by vger.kernel.org with ESMTP id <S261600AbSKNS3y>;
	Thu, 14 Nov 2002 13:29:54 -0500
Date: Thu, 14 Nov 2002 20:36:46 +0200 (EET)
From: Jani Averbach <jaa@cc.jyu.fi>
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Solved: Re: How do I re-activate IDE controller (secondary channel)
 after boot?
In-Reply-To: <Pine.LNX.4.33.0211141048050.10843-100000@router.windsormachine.com>
Message-ID: <Pine.GSO.4.33.0211142030240.7506-100000@tukki.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Mike Dresser wrote:

>
> take a look at the Large-Disk-HOWTO
>
> www.win.tue.nl/~aeb/linux/Large-Disk-11.html#ss11.3
>

I don't know how I did miss this one, because I read (some part of) that
howto...

> As well, there appears to be kernel patches, these appear to have been
> applied to 2.5.3 and above, but maybe not 2.4.x?
>

Yes, with 2.5.47, CONFIG_IDEDISK_STROKE=y and with 32G jumper, the drive
and bios are working together, and the size is precisely right.


Big Thanks!

BR, Jani

P.S. The drive is Seagate barracuda ATA IV 80G (ST380021A).

--
Jani Averbach

