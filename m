Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUGKHEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUGKHEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUGKHEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:04:53 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7143 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266508AbUGKHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:04:51 -0400
Date: Sun, 11 Jul 2004 03:07:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Con Kolivas <kernel@kolivas.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <40F008B0.8020702@kolivas.org>
Message-ID: <Pine.LNX.4.58.0407110305420.29060@montezuma.fsmlabs.com>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org>
 <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
 <20040710151455.GA29140@devserv.devel.redhat.com> <40F008B0.8020702@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Con Kolivas wrote:

> Arjan van de Ven wrote:
> > On Sun, Jul 11, 2004 at 01:12:28AM +1000, Con Kolivas wrote:
> >
> >>I've conducted some of the old fashioned Benno's latency test on this
> >
> >
> > is that the test which skews with irq's disabled ? (eg uses normal
> > interrupts and not nmi's for it's initial time inrq)
>
> It probably is; in which case all these results would be useless, no?
>
> http://www.gardena.net/benno/linux/latencytest-0.42.tar.gz

I think Arjan is referring to rtl_latencytest.c
