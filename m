Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbSK3QVP>; Sat, 30 Nov 2002 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267269AbSK3QVP>; Sat, 30 Nov 2002 11:21:15 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:6874 "EHLO
	mailrelay.tugraz.at") by vger.kernel.org with ESMTP
	id <S267267AbSK3QVO>; Sat, 30 Nov 2002 11:21:14 -0500
Date: Sat, 30 Nov 2002 17:22:12 +0100 (CET)
From: Martin Pirker <crf@sbox.tugraz.at>
X-X-Sender: crf@pluto.tugraz.at
To: linux-kernel@vger.kernel.org
Subject: Re: cache size misdetected with 2.4.20 + P3m
In-Reply-To: <20021130010220.GA3277@suse.de>
Message-ID: <Pine.LNX.4.44.0211301715590.20537-100000@pluto.tugraz.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 30 Nov 2002, Dave Jones wrote:
> On Sat, Nov 30, 2002 at 01:08:40AM +0100, Martin Pirker wrote:
>  > Question: Where has the cache gone? Is this just wrong in /proc/cpuinfo
>  > or are really just 32KB used? (and how to test this?)
> 
> Should be fixed if you apply my patch too.
> ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.4/2.4.20/descriptors.diff
> 
> let me know how that works out..

yep, that shows 512kb again

tnx!
Martin

PS: cpufreq is very useful :)

