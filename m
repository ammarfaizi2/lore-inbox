Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTHCB7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270727AbTHCB7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:59:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:45476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270724AbTHCB7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:59:49 -0400
Date: Sat, 2 Aug 2003 19:00:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm3
Message-Id: <20030802190055.5e600c20.akpm@osdl.org>
In-Reply-To: <1059875394.618.0.camel@teapot.felipe-alfaro.com>
References: <20030802152202.7d5a6ad1.akpm@osdl.org>
	<1059875394.618.0.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> On Sun, 2003-08-03 at 00:22, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm3/
> > 
> > . Con's CPU scheduler rework has been dropped out and Ingo's changes have
> >   been added.
> 
> Why?

Because of the other reasons which I mentioned?  We need additional
infrastructure such as the nanosecond timing to do this right.
