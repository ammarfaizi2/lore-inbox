Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVH0V2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVH0V2W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 17:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVH0V2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 17:28:22 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:15024 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750804AbVH0V2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 17:28:22 -0400
X-ORBL: [67.124.117.85]
Date: Sat, 27 Aug 2005 14:28:17 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Kent Robotti <dwilson24@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050827212817.GA2951@taniwha.stupidest.org>
References: <20050827081918.GA963@Linux.nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050827081918.GA963@Linux.nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 08:19:18AM +0000, Kent Robotti wrote:

> I know that experience dosen't come from packing the kernel source,
> or the zillion other tar archives on the internet.

Are you deliberately trying to be annoying?   Let me guess:

  - your under 25 years of age, probably in high school or not far
    out of it

  - you have a stupid oversized wanky computer case with neon
    lighting and useless analog dials and what not.  you might have
    even overclocked it

  - you've run windows most of your live

  - you probably run gentoo now.  you like the feeling of having
    everything optimized for your exact system; the addition 0.25%
    speed increase more than offsets the fact everything is crappy
    and crashes all the time

  - you run reiserfs, you probably can't wait till reiser4 is merged
    so you can run that

  - you're very interesting in real-time patches.  linux should
    clearly have all real-time stuff merged.  second to your interest
    in realtime is probably something like selinux

  - if you drive a car, it has extra spoilers added and you've
    replaced the steering wheel with something from MOMO

  - you 'friends' are worried you'll die a virgin

Please.

How about you do a little research on some things for a bit?  The
initramfs code is done the way it is for a good reason.  cpio is used
over tar for another good reason.

You are most welcome to disagree and even voice you disagreement, but
there comes a point where you really need to produce some better
arguments.  Patches wouldn't hurt either.
