Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272276AbTHDW0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272280AbTHDW0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:26:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:60039 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272276AbTHDW0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:26:21 -0400
Date: Mon, 4 Aug 2003 15:27:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: swsusp updates
Message-Id: <20030804152734.3227216d.akpm@osdl.org>
In-Reply-To: <20030804221349.GC3078@elf.ucw.cz>
References: <20030804201432.GA467@elf.ucw.cz>
	<20030804134338.5d0f65cd.akpm@osdl.org>
	<20030804221349.GC3078@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This should fix it: (incremental).

It generates rejects against Linus's current tree.

Please grab the latest from

ftp://ftp.kernel.org/pub/linux/kernel/v2.5/testing/cset/index.html

rediff, retest with various config options, resend.
