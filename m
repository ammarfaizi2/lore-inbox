Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSKBADW>; Fri, 1 Nov 2002 19:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265832AbSKBADW>; Fri, 1 Nov 2002 19:03:22 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:27268 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265830AbSKBADT>;
	Fri, 1 Nov 2002 19:03:19 -0500
Date: Sat, 2 Nov 2002 00:09:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] swap mini-howto
Message-ID: <20021102000907.GA9229@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0211011540140.28320-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 03:58:27PM -0800, Randy.Dunlap wrote:
 > 
 > Hi,
 > 
 > Last week I was looking for a swap-space (mini) HOWTO and
 > didn't find one, so I threw one together quickly.  It's at
 >   http://www.xenotime.net/linux/swap-mini-howto.txt
 > (Yeah, I know that this isn't a tough subject, but sometimes
 > people need something like this.)

I could have sworn I've seen one of these before..

 > I'm sure that it has some things that need to be corrected,
 > so if any of you could send such corrections to me, I'd
 > appreciate it.

Might be nice to mention that using multiple swap partitions
on different disks will 'stripe' requests across disks a-la-raid0

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
