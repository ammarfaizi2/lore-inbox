Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUCDGlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCDGlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:41:05 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29842 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261480AbUCDGlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:41:01 -0500
Date: Thu, 4 Mar 2004 12:10:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm4-rcu_ll SMP memory leak ?
Message-ID: <20040304064048.GA4155@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1078378468.22198.10.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078378468.22198.10.camel@twins>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Thu, Mar 04, 2004 at 06:34:28AM +0100, Peter Zijlstra wrote:
> I'm running said kernel, and after 5 days I've noticed that all my
> memory is gone. Even if I quit every possible application there is
> still 600MB+ gone, not in buffers/cache but just used, and no app to
> show for it.
> 
> I append my current uname,top and lsmod output (while writing this mail)
> and as one can see I'm lucky if the RES column adds up to 150m.
> 
> is there some way to see how much memory the kernel uses for its
> internal structures and then maybe pinpoint the leak?
> 
> Kind regards,
> 
> Peter Zijlstra
> 
> 
> 
> Linux ####### 2.6.3-mm4-rcu_ll #1 SMP Fri Feb 27 09:32:12 CET 2004 i686
> AMD Athlon(tm) Processor AuthenticAMD GNU/Linux


What is 2.6.3-mm4-rcu_ll ? AFAIK, there is no such tree.
Is it vanilla 2.6.3-mm4 or it has some other patches in it ? If
it has other patches, what are those ? Pointers ? Code ?

Dipankar
