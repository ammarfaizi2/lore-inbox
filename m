Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUASGr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 01:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUASGr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 01:47:58 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:10641 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S264410AbUASGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 01:47:57 -0500
Date: Mon, 19 Jan 2004 07:47:56 +0100
From: Sander <sander@humilis.net>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Sander <sander@humilis.net>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: several oopses during boot (was: Re: [PATCH] Add CONFIG for -mregparm=3)
Message-ID: <20040119064756.GA9708@favonius>
Reply-To: sander@humilis.net
References: <20040114090603.GA1935@averell> <20040117201639.GA16420@favonius> <20040117205302.GA16658@colin2.muc.de> <20040117210715.GA15172@favonius> <20040117212857.GA28114@colin2.muc.de> <20040118054442.GA32278@favonius> <20040118203459.GB8500@favonius> <20040118210017.GB68521@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118210017.GB68521@colin2.muc.de>
X-Uptime: 07:25:48 up 31 days, 21:14, 36 users,  load average: 1.16, 1.99, 2.45
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote (ao):
> > I have no idea if it is hardware or software related, and if it has
> > got anything to do with the REGPARM option, but I entered this
> > thread because the kernel oopsed the first time I booted it and the
> > first time I enabled this option.
> 
> Do the oopses go away when you disable the option? And do they come
> back when you reenable it again? 

I have to try that, but have no reliable way to get the oopses yet which
makes that a bit hard.

> You could run memtest86 to make sure your RAM is ok.

I'll do that.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
