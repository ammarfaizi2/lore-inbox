Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUHNKtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUHNKtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUHNKtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:49:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:51670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266357AbUHNKtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:49:06 -0400
Date: Sat, 14 Aug 2004 03:49:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
In-Reply-To: <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
 <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Aug 2004, Linus Torvalds wrote:
> 
> Andrew, since I'm gone in another hour, how about you try to make a
> 2.6.8.1 with this, since this is clearly a good reason for one?

Ahh. Jeff posted the right one, obviously. Pushed to BK.

I'll make a 2.6.8.1 myself, to make it usable for people with NFS.

		Linus
