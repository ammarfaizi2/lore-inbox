Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTIHL4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTIHL4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 07:56:31 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:38785
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261623AbTIHL4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 07:56:30 -0400
Date: Mon, 8 Sep 2003 07:55:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] asm-arm/tlbflush.h needs some extra headers
In-Reply-To: <20030908084009.A1092@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0309080754240.14426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309080026100.14426@montezuma.fsmlabs.com>
 <20030908084009.A1092@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Russell King wrote:

> Hmm, does akpm's -mm6 patch contain any header file cleanups?  I know
> this file built in Linus' bk tree last night, although this wasn't
> for SA1100.
> 
> Can you check whether arch/arm/kernel/setup.c includes asm/cacheflush.h
> just before asm/tlbflush.h (which is a recent fix which went into Linus'
> tree recently.)

Nope it does not. I'll pick that from Linus' tree.

Thanks
