Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUHUSkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUHUSkD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267631AbUHUSix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 14:38:53 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37364 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267647AbUHUSil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 14:38:41 -0400
Date: Sat, 21 Aug 2004 14:42:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, torvalds@osdl.org, kaos@sgi.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
In-Reply-To: <20040821113459.14b9d4ad.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408211442190.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408211320520.27390@montezuma.fsmlabs.com>
 <20040821113459.14b9d4ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Sat, 21 Aug 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > It's been benchmarked with bonnie++ on 2x and 4x PIII
>
> What were the results?

Sorry boss;

http://www.zwane.ca/results/cool-locks-stp
