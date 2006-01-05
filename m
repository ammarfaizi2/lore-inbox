Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752299AbWAEXdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbWAEXdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbWAEXdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:33:00 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:37315 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752296AbWAEXc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:32:59 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client   =?iso-8859-1?q?on=09interactive?= response
Date: Fri, 6 Jan 2006 10:33:09 +1100
User-Agent: KMail/1.8.2
Cc: Mike Galbraith <efault@gmx.de>, Helge Hafting <helgehaf@aitel.hist.no>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20060105070601.026b21f0@pop.gmx.net> <5.2.1.1.2.20060105143705.00be85c8@pop.gmx.net> <43BDA80C.4020009@bigpond.net.au>
In-Reply-To: <43BDA80C.4020009@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601061033.10001.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 10:13 am, Peter Williams wrote:
> If the plugsched patches were included in -mm we could get wider testing
> of alternative scheduling mechanisms.  But I think it will take a lot of
> testing of the new schedulers to allay fears that they may introduce new
> problems of their own.

When I first generated plugsched and posted it to lkml for inclusion in -mm it 
was blocked as having no chance of being included by both Ingo and Linus and 
I doubt they've changed their position since then. As you're well aware this 
is why I gave up working on it and let you maintain it since then. Obviously 
I thought it was a useful feature or I wouldn't have worked on it.

Con
