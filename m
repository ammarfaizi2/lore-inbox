Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVFGRaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFGRaJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFGRaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:30:09 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.25]:15706 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261191AbVFGRaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:30:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050607160400.GA9904@elte.hu>
References: <20050607110409.GA14613@elte.hu>
	 <Pine.OSF.4.05.10506071638130.28240-100000@da410.phys.au.dk>
	 <20050607160400.GA9904@elte.hu>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 19:30:05 +0200
Message-Id: <1118165405.13708.57.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 18:04 +0200, Ingo Molnar wrote:

> thanks - i've applied it and have released the -47-27 patch with this 
> fix included.

In how bad a shape is ALL_TASKS_PI in that patch?
And is your TASK_NONINTERACTIVE patch needed with -RT kernels?; it
doesn't apply cleanly but I guess I can manage to get it in; it's only a
few lines of code anyway ;-)


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

