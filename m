Return-Path: <linux-kernel-owner+willy=40w.ods.org-S284343AbUKASCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S284343AbUKASCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUKAR4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:56:37 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47552 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S283667AbUKARzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:55:17 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Date: Mon, 1 Nov 2004 09:54:50 -0800
User-Agent: KMail/1.7
Cc: Pavel Machek <pavel@ucw.cz>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz> <20041101114124.GA31458@elte.hu>
In-Reply-To: <20041101114124.GA31458@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411010954.50184.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 1, 2004 3:41 am, Ingo Molnar wrote:
> Sched-domains is nice for both the low-end and the high-end - it enables
> 512 CPU single-system-image systems supported by (almost-) vanilla 2.6
> kernel. What more can we ask for?

Minor correction: last I checked, a 512p booted with the vanilla kernel.  
We're working hard to keep it that way :).  (Witness John Hawkes' patch to 
fixup the load balancing stuff recently.)

Jesse
