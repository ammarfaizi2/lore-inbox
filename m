Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbUAIVmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbUAIVmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:42:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:17116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264445AbUAIVkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:40:04 -0500
Date: Fri, 9 Jan 2004 13:41:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kgdb cleanups
Message-Id: <20040109134117.4dcd9db8.akpm@osdl.org>
In-Reply-To: <20040109183826.GA795@elf.ucw.cz>
References: <20040109183826.GA795@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> No real code changes, but cleanups all over the place. What about
> applying?
> 
> Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> do x86-64 version so that is rather important.

Could you please work this with the kgdb developers?

	Jim Houston <jim.houston@comcast.net>
	george anzinger <george@mvista.com>
	"Amit S. Kale" <amitkale@emsyssoft.com>

Because merging this might stomp all over work which they have in progress.

(But thanks: kgdb does need a cleanup)

