Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWCQXgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWCQXgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWCQXgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:36:38 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14725 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751413AbWCQXgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:36:37 -0500
Date: Fri, 17 Mar 2006 16:36:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.16-rc6-rt7
Message-ID: <20060317233636.GB26253@smtp.west.cox.net>
References: <20060316095607.GA28571@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316095607.GA28571@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:

> i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/

I was wondering, is it normal for the nanosleep02 and alarm02 LTP tests
to fail?  For sometime I've seen these tests fail from time to time with
the -RT patch but not the regular kernel.

-- 
Tom Rini
http://gate.crashing.org/~trini/
