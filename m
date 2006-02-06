Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWBFAmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWBFAmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 19:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBFAmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 19:42:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbWBFAmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 19:42:03 -0500
Date: Sun, 5 Feb 2006 16:41:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] small cleanups
Message-Id: <20060205164138.1cd61d5c.akpm@osdl.org>
In-Reply-To: <20060205114229.GA3110@elf.ucw.cz>
References: <20060205114229.GA3110@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> While hacking system stopping, I ran around few trivial places that
> could be cleaned up... No code changes.
> 

This patch is a bit too random for me.

Sure, if you wnat to do a cleanup of signal.c and pdflush.c then feel free
to do so, but I don't think this does it.  It's just a little touchup of a
couple of places.  My concern is that we could apply 1000 patches like
that.  Would much prefer less, larger, more comprehensive patches.


