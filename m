Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJXHVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJXHVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVJXHVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:21:39 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:7073 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750727AbVJXHVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:21:38 -0400
Date: Mon, 24 Oct 2005 16:13:26 +0900 (JST)
Message-Id: <20051024.161326.95910283.taka@valinux.co.jp>
To: pj@sgi.com
Cc: akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       clameter@sgi.com, torvalds@osdl.org, linux-mm@kvack.org
Subject: Re: [PATCH] cpuset confine pdflush to its cpuset
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20051023234918.386364c0.pj@sgi.com>
References: <20051023233237.0982b54b.pj@sgi.com>
	<20051023234032.5e926336.akpm@osdl.org>
	<20051023234918.386364c0.pj@sgi.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Andrew wrote:
> > Let's see a (serious) worload/testcase first, hey?
> 
> A reasonable request.

Can you do this?
I think you may probably use a large NUMA machine.

> > >   ( Anyone know what the "pd" stands for in pdflush ?? )
> > 
> > "page dirty"?  It's what bdflush became ...
> 
> Ah - thanks.

