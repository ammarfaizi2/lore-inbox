Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSKKX5S>; Mon, 11 Nov 2002 18:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264757AbSKKX5S>; Mon, 11 Nov 2002 18:57:18 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:24084
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264756AbSKKX5R>; Mon, 11 Nov 2002 18:57:17 -0500
Date: Mon, 11 Nov 2002 18:58:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: Andrew Morton <akpm@digeo.com>, Ben Clifford <benc@hawaga.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: programming for preemption (was: [PATCH] 2.5.46: access permission
 filesystem)
In-Reply-To: <87znsgov9e.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0211111857090.30128-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Olaf Dietsche wrote:

> Thanks for this hint. So this means kmalloc(GFP_KERNEL) inside
> spinlock is not necessarily dangerous, but should be avoided if
> possible? Is using a semaphore better than using spinlocks? Is
> there a list of dos and don'ts for preempt kernels beside
> Documentation/preempt-locking.txt?
> 
> And btw, who is "us"?

The Cab^Kernel developers ;)

-- 
function.linuxpower.ca

