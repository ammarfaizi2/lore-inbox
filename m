Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUFSXGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUFSXGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFSXGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:06:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:38574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264767AbUFSXGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:06:42 -0400
Date: Sat, 19 Jun 2004 16:05:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Message-Id: <20040619160532.49934355.akpm@osdl.org>
In-Reply-To: <200406200117.38691.dominik.karall@gmx.net>
References: <20040619210714.GD3243@iucha.net>
	<200406200117.38691.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Saturday 19 June 2004 23:07, Florin Iucha wrote:
> > Hello,
> >
> > I have updated my kernel to 2.6.7-bk2 this morning and it felt faster
> > than 2.6.7! It feels faster in firefox and it is noticeably faster in
> > gnome-terminal. Goodness!
> >
> > But, there is downside as well: the clock runs faster. 125-150% faster ;(
> > It is weird since the time server does not correct it.
> >
> > Can I get the speed with a correct clock? Please?
> >
> > florin
> 
> Yes, same here!

dmesg and .config, please.
