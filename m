Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbUL2AR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbUL2AR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbUL2AR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:17:57 -0500
Received: from lucidpixels.com ([66.45.37.187]:38300 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261266AbUL2ARz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:17:55 -0500
Date: Tue, 28 Dec 2004 19:17:53 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel Benchmarks With P4+SMP+SMT?
Message-ID: <Pine.LNX.4.61.0412281914380.11816@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone performed any benchmarks with:

No SMP w/HT?
SMP w/HT?
SMP + SMT w/HT?

[ ] Symmetric multi-processing support
[ ]   SMT (Hyperthreading) scheduler support

   x SMT scheduler support improves the CPU scheduler's decision making
   x when dealing with Intel Pentium 4 chips with HyperThreading at a
   x cost of slightly increased overhead in some places. If unsure say
   x N here.

I'm tempted to try SMT and benchmark these sometime but I am asking the 
list if anyone has already done this first.

Question: "slightly increased overhead in some places."

What type of workloads would exhibit such overhead?

Would this option (SMT) be recommended for a desktop or server machine?

Are there any white papers or documentation I can read about this option?

Thanks.

