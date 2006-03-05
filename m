Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752229AbWCELkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbWCELkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 06:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbWCELkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 06:40:05 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:54469 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752174AbWCELkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 06:40:04 -0500
Date: Sun, 5 Mar 2006 17:08:47 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
Message-ID: <20060305113847.GE21751@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060304.142821.105572446.davem@davemloft.net> <20060304.143222.01803877.davem@davemloft.net> <20060305070537.GB21751@in.ibm.com> <20060304.233725.49897411.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304.233725.49897411.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 11:37:25PM -0800, David S. Miller wrote:
> From: Dipankar Sarma <dipankar@in.ibm.com>
> Date: Sun, 5 Mar 2006 12:35:38 +0530
> 
> > Can you check if the following patchset applies to the latest git ?
> > These were against 2.6.16-rc3.
> > 
> > http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/rcu-batch-tuning.patch
> > http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/percpu-counter-sum.patch
> > http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/fix-file-counting.patch
> 
> Applies with some fuzz to kernel/sysctl.c

Great. I look forward to hearing from you about the results
with your test case.

Thanks
Dipankar
