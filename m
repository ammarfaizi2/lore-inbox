Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTL2UNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTL2ULV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:11:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:59834 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263792AbTL2ULG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:11:06 -0500
Date: Mon, 29 Dec 2003 12:11:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
In-Reply-To: <20031229205246.A32604@infomag.infomag.iguana.be>
Message-ID: <Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be>
 <20031229205246.A32604@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Wim Van Sebroeck wrote:
>
> Hi Linus, Andrew,
> 
> please do a
> 
> 	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog

This tree has 38 deltas, all just merges.

The end result is a horribly messy revision tree, for a few one-liners.

I'm going to take the patch as a patch instead, and hope that you'll throw 
your BK tree away.

Please don't follow the release tree in your development trees, it makes 
it impossible to see how the revision history happened.

		Linus
