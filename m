Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUBLOrV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266464AbUBLOrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:47:20 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:49859 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S266463AbUBLOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:47:19 -0500
Date: Thu, 12 Feb 2004 09:46:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Christine Moore <cem@osdl.org>
Subject: Re: 2.6.3-rc2-mm1
In-Reply-To: <402B6251.2060909@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0402120936540.32441@montezuma.fsmlabs.com>
References: <20040212015710.3b0dee67.akpm@osdl.org> <402B6251.2060909@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Nick Piggin wrote:

> Andrew Morton wrote:
>
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/
> >
> >
>
> Nether this nor the previous one boots on the NUMAQ at osdl.
> Not sure which is the last -mm that did. 2.6.3-rc2 boots.
>
> I turned early_printk on and nothing. It stops at
> Loading linux..............

Ahh thanks Nick, i tried this last night too and was going to start
working backwards. 2.6.3-rc2 doesn't look like far to work from.
