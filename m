Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbUARFos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUARFos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 00:44:48 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:32908 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S265838AbUARFoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 00:44:46 -0500
Date: Sun, 18 Jan 2004 06:44:42 +0100
From: Sander <sander@humilis.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Sander <sander@humilis.net>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040118054442.GA32278@favonius>
Reply-To: sander@humilis.net
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius> <20040117212857.GA28114@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117212857.GA28114@colin2.muc.de>
X-Uptime: 05:12:04 up 31 days, 19:00, 37 users,  load average: 1.14, 1.10, 1.03
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote (ao):
> On Sat, Jan 17, 2004 at 10:07:15PM +0100, Sander wrote:
> > > > Without the REGPARM option the system boots and runs fine.
> > > > 
> > > > Should I post the oopses, the result of ksymoops, a dmesg and
> > > > kernel config or is this an already known issue?
> > > 
> > > Not known. Please post the decoded oopses.  Also give your
> > > compiler version.
> > 
> > Hope this helps. The system runs fine with the option disabled.
> 
> Can you perhaps save your .config, do a make distclean and try
> to compile the kernel from scratch again? Maybe you had some stale
> object files around. 

I'm terrible sorry to say that I can't reproduce the oopses
anymore ..  :-(  Maybe something went wrong during the tftp of the
kernel, or I made a mistake ..

Sorry for wasting your time ..

sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
