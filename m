Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbSK3A6Q>; Fri, 29 Nov 2002 19:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbSK3A6Q>; Fri, 29 Nov 2002 19:58:16 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34699 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267196AbSK3A6Q>;
	Fri, 29 Nov 2002 19:58:16 -0500
Date: Sat, 30 Nov 2002 01:02:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Martin Pirker <crf@sbox.tugraz.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cache size misdetected with 2.4.20 + P3m
Message-ID: <20021130010220.GA3277@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Martin Pirker <crf@sbox.tugraz.at>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211300056180.29587-100000@pluto.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211300056180.29587-100000@pluto.tugraz.at>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 01:08:40AM +0100, Martin Pirker wrote:
 > Question: Where has the cache gone? Is this just wrong in /proc/cpuinfo
 > or are really just 32KB used? (and how to test this?)

Should be fixed if you apply my patch too.
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff

let me know how that works out..

		Dave
		
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
