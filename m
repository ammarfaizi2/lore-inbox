Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUGKHHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUGKHHD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 03:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUGKHHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 03:07:02 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:13031 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266505AbUGKHGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 03:06:55 -0400
Date: Sun, 11 Jul 2004 03:09:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <20040711064730.GA11254@elte.hu>
Message-ID: <Pine.LNX.4.58.0407110308120.29060@montezuma.fsmlabs.com>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org>
 <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
 <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jul 2004, Ingo Molnar wrote:

>
> * Con Kolivas <kernel@kolivas.org> wrote:
>
> > Ooops forgot to mention this was running reiserFS 3.6 on software
> > raid0 2x IDE with cfq elevator.
>
> ok, reiserfs (and all journalling fs's) definitely need a look - as you
> can see from the ext3 mods in the patch. Any chance you could try ext3
> based tests? Those are the closest to my setups.

Ingo, what are you using for measuring thread wakeup latency?

