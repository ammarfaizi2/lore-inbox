Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTAaO05>; Fri, 31 Jan 2003 09:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbTAaO05>; Fri, 31 Jan 2003 09:26:57 -0500
Received: from surfer.sbm.temple.edu ([155.247.185.2]:58180 "EHLO
	surfer.sbm.temple.edu") by vger.kernel.org with ESMTP
	id <S261286AbTAaO04>; Fri, 31 Jan 2003 09:26:56 -0500
Date: Fri, 31 Jan 2003 09:36:09 -0500
From: AU <au@sbm.temple.edu>
To: Chris Ison <cisos@bigpond.net.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Radeon PCI support
In-Reply-To: <3E398E44.E2D16B4F@bigpond.net.au>
Message-ID: <Pine.SGI.4.32.0301310930470.9740052-100000@surfer.sbm.temple.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got it working last night with my home computer, which has
ATI-Radeon 7500 PCI version.
However, now I am  at work, so I will post for you tonight when I get
home.

Couple things I have done.

1) Modify kernel (/usr/src/linux/driver/char/drm/radeon_cp.c
2) Download xfree 4.2.1 and modify couple files in it, and
recompile.

I will post the diff file tonite.

Progress: This morning I tested, I can run 3D Crack-Attack, and tuxracer.
I will test more, and let you know.


On Fri, 31 Jan 2003, Chris Ison wrote:

> just a couple of things I forgot to mention, my system doesn't have AGP
> and I'm using kernel version 2.4.20-ac1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

