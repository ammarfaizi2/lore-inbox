Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUIJO2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUIJO2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUIJO2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:28:44 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:63717 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267424AbUIJO2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:28:43 -0400
Message-ID: <4d8e3fd30409100728bd6c9c1@mail.gmail.com>
Date: Fri, 10 Sep 2004 16:28:37 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, felipe_alfaro@linuxmail.org,
       mista.tapas@gmx.net, kr@cybsft.com, mark_h_johnson@raytheon.com
In-Reply-To: <20040910132841.GA8552@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <20040906110626.GA32320@elte.hu>
	 <1094626562.1362.99.camel@krustophenia.net>
	 <20040909192924.GA1672@elte.hu>
	 <20040909130526.2b015999.akpm@osdl.org>
	 <20040910132841.GA8552@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004 15:28:41 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > diff -puN mm/vmscan.c~swapspace-layout-improvements mm/vmscan.c
> > --- 25/mm/vmscan.c~swapspace-layout-improvements      2004-06-03 21:32:51.087602712 -0700
> > +++ 25-akpm/mm/vmscan.c       2004-06-03 21:32:51.102600432 -0700
> 
> i've attached a merge against current BK-ish kernels. Lee, would you be
> interested in testing it? It applies cleanly to an -S0 VP tree. I've
> tested it only lightly - it compiles and boots and survives some simple
> swapping but that's all.

Hello kernel folks,
what's the plan regarding the inclusion of VP in mainstream ?



-- 
Paolo
Personal home page: paoloc.doesntexist.org
Buy cool stuff here: http://www.cafepress.com/paoloc
