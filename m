Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSKSOAH>; Tue, 19 Nov 2002 09:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSKSOAH>; Tue, 19 Nov 2002 09:00:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:30439 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265457AbSKSOAF>;
	Tue, 19 Nov 2002 09:00:05 -0500
Date: Tue, 19 Nov 2002 14:02:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Paul Larson <plars@linuxtestproject.org>
Cc: jim.houston@attbi.com, lkml <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
Message-ID: <20021119140205.GA30120@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Paul Larson <plars@linuxtestproject.org>, jim.houston@attbi.com,
	lkml <linux-kernel@vger.kernel.org>,
	high-res-timers-discourse@lists.sourceforge.net,
	ltp-list@lists.sourceforge.net, jim.houston@ccur.com
References: <200211190127.gAJ1RWg11023@linux.local> <1037713044.24031.15.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037713044.24031.15.camel@plars>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 07:37:23AM -0600, Paul Larson wrote:
 > > I just tried gettimeofday02 on an old pentium-pro dual processor, and yes
 > > the time goes backwards with a 2.5.48 kernel.
 > This has been noticed, I've posted to lkml about it.  The only person
 > who replied to me seems to be suggesting it is a hardware issue, but I
 > can't believe it is impossible to work around.

Especially if earlier kernels got it right..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
