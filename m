Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVGKXqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVGKXqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVGKXoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:44:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262284AbVGKXmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:42:47 -0400
Date: Mon, 11 Jul 2005 16:43:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add type-checking to pm_message_t
Message-Id: <20050711164347.4903925c.akpm@osdl.org>
In-Reply-To: <20050711184904.GA1970@elf.ucw.cz>
References: <20050711184904.GA1970@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This adds type-checking to pm_message_t, so that people can't confuse
> it with int or u32.

hm, well large amounts of this patch had already been applied by various
trees, including Linus's.

So I merged up the leftovers and we'll see what happens...
