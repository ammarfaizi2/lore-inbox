Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVBHWv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVBHWv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVBHWv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:51:57 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37648 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261674AbVBHWvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:51:55 -0500
Date: Tue, 8 Feb 2005 23:45:31 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208224531.GE1850@alpha.home.local>
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208184145.GD10799@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Tue, Feb 08, 2005 at 04:41:46PM -0200, Marcelo Tosatti wrote:
> > 
> > 	There need to be some unique features in 2.6.X to force people
> > to upgrade, I guess...
> 
> Faster, cleaner, way more elegant, handles intense loads more gracefully, 

When a CPU-hungry task freezes another one for more than 13 seconds, I cannot
agree with your last statement, and that's why I still don't upgrade. I have
already posted examples of worst case scenarios, but I now start to have a
more meaningful example to show so that people working on the scheduler may
have something clearer to work with. I also did not have time to retest -ck
or staircase recently, but I will do for completeness.

> handles highmem decently, LSM/SELinux, etc, etc...
> 
> IMO everyone should upgrade whenever appropriate. 

I still know about a tens of 2.2 still running around at customers ;-)
However, if it had not been for lazyness, they should have upgraded.

Cheers,
Willy

