Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTBQAdD>; Sun, 16 Feb 2003 19:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTBQAdD>; Sun, 16 Feb 2003 19:33:03 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37765 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266347AbTBQAdC>;
	Sun, 16 Feb 2003 19:33:02 -0500
Date: Mon, 17 Feb 2003 00:55:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq on athlon4
Message-ID: <20030217005536.GB17448@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030215221236.GA210@elf.ucw.cz> <20030216144941.GA4459@codemonkey.org.uk> <20030216160306.GC2367@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216160306.GC2367@elf.ucw.cz>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:03:06PM +0100, Pavel Machek wrote:

 > > Its likely at some point I'll implement a way to override using
 > > the BIOS table too.
 > 
 > So you think that in fact I should be able to run at lower
 > voltage?

I've seen two different laptops from differnent vendors both with the
same CPU, with wildly differing PST tables, so its very likely
yes. And the fact that the powernow registers state that it
supports voltage scaling, and then not offering any in the PST
seems a bit silly.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
