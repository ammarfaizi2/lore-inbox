Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUEXB6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUEXB6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUEXB6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:58:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:52687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263823AbUEXB6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:58:43 -0400
Date: Sun, 23 May 2004 18:55:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
In-Reply-To: <40B10EC1.3030602@pobox.com>
Message-ID: <Pine.LNX.4.58.0405231854240.25502@ppc970.osdl.org>
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com>
 <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org> <40B10EC1.3030602@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Jeff Garzik wrote:
> 
> Sorta like I'm hoping that cheap and prevalent 64-bit CPUs make PAE36 
> and PAE40 on ia32 largely unnecessary.  Addressing more memory than 32 
> bits of memory on a 32-bit CPU always seemed like a hack to me, and a 
> source of bugs and lost performance...

I agree. I held out on PAE for a longish while, in the unrealistic hope 
that people would switch to alpha's. 

Oh, well. I don't expect _everybody_ to switch to x86-64 immediately, but 
I hope we can hold out long enough without 4g that it does work out this 
time.

		Linus
