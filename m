Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbUJ1U5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbUJ1U5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUJ1Uw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:52:56 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:54516 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263070AbUJ1Uwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:52:41 -0400
Date: Thu, 28 Oct 2004 13:51:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, akpm@osdl.org,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces
Message-ID: <20041028205136.GA1888@taniwha.stupidest.org>
References: <200410272223.i9RMNj921852@mail.osdl.org> <200410282034.21922.blaisorblade_spam@yahoo.it> <20041028192824.GC851@taniwha.stupidest.org> <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282132.i9SLWhA3004709@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 05:32:43PM -0400, Jeff Dike wrote:

> They're not completely pointless, they just cater to an individual's
> development environment, and that sort of stuff should be in the
> environment, and not the code.

unnecessary in the code then, the exception to this perhaps being the
compile-command stuff that was (still is?) in some of the network
drivers as that really is per-file state
