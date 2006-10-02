Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965417AbWJBVhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965417AbWJBVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965418AbWJBVhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:37:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965417AbWJBVhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:37:06 -0400
Date: Mon, 2 Oct 2006 14:36:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Samuel Tardieu <sam@rfc1149.net>,
       Ben Dooks <ben-linux@fluff.org>, Vitaly Wool <vitalywool@gmail.com>,
       Jiri Slaby <jirislaby@gmail.com>, Alan Cox <alan@redhat.com>
Subject: Re: [WATCHDOG] v2.6.19 watchdog patches
Message-Id: <20061002143625.2143e4e4.akpm@osdl.org>
In-Reply-To: <20061002212753.GA9556@infomag.infomag.iguana.be>
References: <20061002212753.GA9556@infomag.infomag.iguana.be>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006 23:27:53 +0200
Wim Van Sebroeck <wim@iguana.be> wrote:

> If no-one objects, can you please pull from 'master' branch of
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

OK by me.

I notice that you're holding back a couple of drivers:
drivers/char/watchdog/iTCO_wdt.c and
drivers/char/watchdog/smsc37b787_wdt.c.  Not ready yet?
