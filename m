Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTEWXLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 19:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTEWXLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 19:11:06 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:16647 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S264169AbTEWXLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 19:11:05 -0400
Date: Sat, 24 May 2003 01:31:03 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Stian Jordet <liste@jordet.nu>
cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irtty_sir cannot be unloaded
In-Reply-To: <1053700929.711.1.camel@chevrolet.hybel>
Message-ID: <Pine.LNX.4.44.0305240127040.11940-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2003, Stian Jordet wrote:

> > I bet pcmcia works without hotplug ;-)
> I might be blind or stupid (or both), but when I disable hotplug, I

Sorry for the confusion, you are right. I meant it works without userland 
hotplug stuff, but that's a mood point as you need to enable kernel 
hotplug to get the pcmcia option even presented - ENOTENOUGHCOFFEIN 8)

> can't enable cardbus at all. :) But davem's patch worked just fine :)
> *happy*

Yep, looks pretty good now.

Martin

