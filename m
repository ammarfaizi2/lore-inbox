Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUH2XOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUH2XOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268387AbUH2XOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:14:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29060 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268370AbUH2XOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:14:03 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040829175058.GP5492@holomorphy.com>
References: <1093786747.1708.8.camel@mulgrave>
	<200408290948.06473.jbarnes@engr.sgi.com>
	<20040829170328.GK5492@holomorphy.com> <1093799390.10990.19.camel@mulgrave>
	<20040829172250.GM5492@holomorphy.com>
	<20040829172923.GN5492@holomorphy.com>
	<20040829174039.GO5492@holomorphy.com> 
	<20040829175058.GP5492@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 19:13:14 -0400
Message-Id: <1093821196.10973.80.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 13:50, William Lee Irwin III wrote:
> On Sun, Aug 29, 2004 at 10:40:39AM -0700, William Lee Irwin III wrote:
> > Okay, if you prefer the #ifdef:
> 
> And for the other half of it:

Much better ... this one looks fine to me and boots OK on an SMP parisc
box.

James


