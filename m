Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUGaUF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUGaUF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGaUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:05:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:2771 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261763AbUGaUFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:05:54 -0400
Date: Sat, 31 Jul 2004 16:09:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm1
In-Reply-To: <Pine.LNX.4.58.0407311519490.4095@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0407311609090.4095@montezuma.fsmlabs.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
 <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
 <20040731114714.37359c2d.akpm@osdl.org> <Pine.LNX.4.58.0407311519490.4095@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Zwane Mwaikambo wrote:

> On Sat, 31 Jul 2004, Andrew Morton wrote:
>
> > Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
> > >
> > > Ingo i believe you have a patch for this, could you push it to Andrew?
> >
> > I suspect Ingo's patch will be livelockable under some circumstances.
> > I suspect mine is too, only less so.
> >
> > > I reckon it's provoked by CONFIG_PREEMPT.
> >
> > This should fix.
>
> Thanks that took care of it.

Oh bugger, spoke too soon, it took a bit longer this time.

