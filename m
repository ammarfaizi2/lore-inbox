Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVBWBry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVBWBry (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 20:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVBWBry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 20:47:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:9365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261389AbVBWBrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 20:47:51 -0500
Date: Tue, 22 Feb 2005 17:48:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.11-rc4 i386] Re-order <linux/fs.h> includes to fix userland
 breakage
In-Reply-To: <20050223013631.GC21662@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0502221748070.2378@ppc970.osdl.org>
References: <20050222215141.GA30663@smtp.west.cox.net>
 <20050223013631.GC21662@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Feb 2005, Chris Wright wrote:
> 
> This change is spewing warnings like:

Already fixed in BK.

		Linus
