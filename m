Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVBICZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVBICZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVBICZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:25:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:35778 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261752AbVBICZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:25:13 -0500
Date: Tue, 8 Feb 2005 18:24:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rth@twiddle.net, mingo@elte.hu, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: out-of-line x86 "put_user()" implementation
Message-Id: <20050208182459.7f5ea4b5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502081805470.2165@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
	<20050207114415.GA22948@elte.hu>
	<Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
	<20050209012543.GA13802@twiddle.net>
	<Pine.LNX.4.58.0502081805470.2165@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Andrew - do you want to put it in -mm? 

I'll take patches from anyone ;)
