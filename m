Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVBHXkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVBHXkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVBHXkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:40:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35724 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261694AbVBHXil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:38:41 -0500
Date: Tue, 8 Feb 2005 18:05:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208200541.GH10799@logos.cnet>
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet> <20050208224531.GE1850@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208224531.GE1850@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 11:45:31PM +0100, Willy Tarreau wrote:
> Hi Marcelo,
> 
> On Tue, Feb 08, 2005 at 04:41:46PM -0200, Marcelo Tosatti wrote:
> > > 
> > > 	There need to be some unique features in 2.6.X to force people
> > > to upgrade, I guess...
> > 
> > Faster, cleaner, way more elegant, handles intense loads more gracefully, 
> 
> When a CPU-hungry task freezes another one for more than 13 seconds, I cannot
> agree with your last statement, and that's why I still don't upgrade. I have
> already posted examples of worst case scenarios, but I now start to have a
> more meaningful example to show so that people working on the scheduler may
> have something clearer to work with. I also did not have time to retest -ck
> or staircase recently, but I will do for completeness.

v2.6 scheduler regressions cannot be tolerated. 

Please prepare more detailed data about your problem - I'm sure Ingo and friends
will appreciate it.

> > handles highmem decently, LSM/SELinux, etc, etc...
> > 
> > IMO everyone should upgrade whenever appropriate. 
> 
> I still know about a tens of 2.2 still running around at customers ;-)
> However, if it had not been for lazyness, they should have upgraded. 

:)
