Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSLHN0u>; Sun, 8 Dec 2002 08:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbSLHN0u>; Sun, 8 Dec 2002 08:26:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1920 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S261290AbSLHN0t>;
	Sun, 8 Dec 2002 08:26:49 -0500
Date: Sun, 8 Dec 2002 08:34:27 -0500 (EST)
From: davidsen <root@tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ctxbench 2.4.18 and 2.5.50
In-Reply-To: <Pine.LNX.4.44.0212080810350.11404-300000@bilbo.tmr.com>
Message-ID: <Pine.LNX.4.44.0212080830430.11459-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Bill Davidsen wrote:

> As these results show, best results were from using a uni kernel, but an 
> SMP kernel with "nosmp" was faster than running SMP. The problem is that 
> with 2.5 kernels the SMP results for multiple runs vary by up to 2:1, and 
> for uni kernels it's more like 5-10% max. I have tried longer runs, more 
> runs, and gotten the same results even in single user mode.

Oops, a note of clarification on test names:
  2.5.50	uni kernel
  2.5.50smp	smp kernel
  2.5.50uni	smp kernel with "nosmp"

Yes, I know that's not intuitive, but all my kernels are SMP, the uni 
tests are an afterthought...

