Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLEBr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTLEBr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:47:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:58577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263645AbTLEBrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:47:55 -0500
Date: Thu, 4 Dec 2003 17:47:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Adams <padamsdev@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0312041743530.6638@home.osdl.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, Paul Adams wrote:
>
> A work that is inspired by Linux is no more a derivative work than
> a programmatic musical composition inspired by a novel.  Having
> Linux in mind cannot be enough to constitute infringement.

But it does - you have to include the Linux header files in order to be
able to make any nontrivial module.

I'm not claiming that "thinking about Linux makes you tainted". It's not
about inspiration. But it's a bit like getting somebody pregnant: you have
to do a lot more than just think about it to actually make it happen, or
every high school in the world would be crawling with babies.

In other words: feel free to be inspired by Linux all you want. But if you
release a binary module that loads and works, you've been doing more than
just feeling inspired. And then you need to be _careful_.

		Linus
