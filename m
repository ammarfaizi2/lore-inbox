Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTJBBQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTJBBQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:16:23 -0400
Received: from dp.samba.org ([66.70.73.150]:23239 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263200AbTJBBQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:16:21 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Shine Mohamed <shinemohamed_j@naturesoft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL][PATCH] Removed unused symbol from drivers/char/esp.c 
In-reply-to: Your message of "Mon, 29 Sep 2003 16:36:06 +0530."
             <200309291636.06040.shinemohamed_j@naturesoft.net> 
Date: Wed, 01 Oct 2003 18:59:48 +1000
Message-Id: <20031002011621.966B32C46D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200309291636.06040.shinemohamed_j@naturesoft.net> you write:
> A quick patch to remove unused symbol from drivers/char/esp.c
> 
> --- drivers/char/esp.c.orig     2003-09-29 14:27:46.000000000 +0530
> +++ drivers/char/esp.c  2003-09-29 14:27:59.000000000 +0530

I've fixed these up, but for future reference, try diffing from one
level down, so the results can be applied with patch -p1 from inside
the directory.

It seems to be the standard, and it's what my scripts expect.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
