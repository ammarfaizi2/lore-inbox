Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWCEHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWCEHhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCEHhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:37:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55241
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751898AbWCEHhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:37:14 -0500
Date: Sat, 04 Mar 2006 23:37:25 -0800 (PST)
Message-Id: <20060304.233725.49897411.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060305070537.GB21751@in.ibm.com>
References: <20060304.142821.105572446.davem@davemloft.net>
	<20060304.143222.01803877.davem@davemloft.net>
	<20060305070537.GB21751@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Sun, 5 Mar 2006 12:35:38 +0530

> Can you check if the following patchset applies to the latest git ?
> These were against 2.6.16-rc3.
> 
> http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/rcu-batch-tuning.patch
> http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/percpu-counter-sum.patch
> http://www.hill9.org/linux/kernel/patches/2.6.16-rc3/fix-file-counting.patch

Applies with some fuzz to kernel/sysctl.c

Thanks a lot!
