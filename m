Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269946AbUJSWXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269946AbUJSWXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269971AbUJSWUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:20:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:29397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269942AbUJSWMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:12:13 -0400
Date: Tue, 19 Oct 2004 15:11:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <4d8e3fd3041019145469f03527@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
References: <41752E53.8060103@pobox.com>  <20041019153126.GG18939@work.bitmover.com>
  <41753B99.5090003@pobox.com>  <4d8e3fd304101914332979f86a@mail.gmail.com>
  <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Oct 2004, Paolo Ciarrocchi wrote:
>
> I know I'm pedantic but can we all see the list of bk trees ("patches
> ready for mainstream" and "patches eventually ready for mainstream")
> that we'll be used by Linus ?

Even _I_ don't have that kind of list. 

It's on a case-by-case basis (although with certain developers, the cases 
tend to be pretty clear-cut), and it literally changes over time. Some 
people use throw-away trees that are just used for some particular set, 
and I merge them (or not), and they go away.

		Linus
