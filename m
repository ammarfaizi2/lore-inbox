Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281323AbRKQVoD>; Sat, 17 Nov 2001 16:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281337AbRKQVnx>; Sat, 17 Nov 2001 16:43:53 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:33268
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281323AbRKQVnq>; Sat, 17 Nov 2001 16:43:46 -0500
Date: Sat, 17 Nov 2001 13:43:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: safemode <safemode@speakeasy.net>
Cc: Alvaro Lopes <alvieboy@alvie.com>, war <war@starband.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap Usage with Kernel 2.4.14
Message-ID: <20011117134327.G21354@mikef-linux.matchmail.com>
Mail-Followup-To: safemode <safemode@speakeasy.net>,
	Alvaro Lopes <alvieboy@alvie.com>, war <war@starband.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF5B275.215D6D44@starband.net> <1005995937.694.0.camel@dwarf> <20011117150505Z281761-17408+15446@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117150505Z281761-17408+15446@vger.kernel.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 10:05:02AM -0500, safemode wrote:
> Also, your box may not be actually doing much swapping if any at all.  vmstat 
> will tell if you're actually doing any swapping at a given time.  
> Allocation may carry over to swap, but it doesn't effect performance in any 
> way in doing so.  That's why looking at anything but vmstat really wont tell 
> you much about what's actually being used in swap. 

procinfo will also list the number of swap(in|out) since the last reboot...
