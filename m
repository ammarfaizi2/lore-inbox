Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbTHQUZu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTHQUZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:25:50 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30848 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270821AbTHQUZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:25:49 -0400
Date: Sun, 17 Aug 2003 21:25:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: michaelc <michaelc@turbolinux.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
Message-ID: <20030817202534.GC3543@mail.jlokier.co.uk>
References: <865464921.20010309170338@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865464921.20010309170338@turbolinux.com.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

michaelc wrote:
>      I read the Intel IA-32 developer's manual recently, and I found
>  the cache lines for L1 and L2 caches in Pentium4 are 64 bytes
>  wide, but the thing make me confused is that the default value
>  CONFIG_X86_L1_CACHE_SHIFT option in 2.4.x kernel is 7, why it's
>  not 6?   Any expanation about this would be appreciated!

I don't recall seeing an answer to this.
Was there one?

Cheers,
-- Jamie
