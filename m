Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTGHSXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGHSXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:23:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12219 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265188AbTGHSXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:23:38 -0400
Date: Tue, 8 Jul 2003 11:31:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, andrea@suse.de,
       peter@chubb.wattle.id.au, akpm@digeo.com, spyro@f2s.com
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-Id: <20030708113155.031b4bc2.akpm@osdl.org>
In-Reply-To: <200307082027.26233.bernie@develer.com>
References: <200307060133.15312.bernie@develer.com>
	<200307070626.08215.bernie@develer.com>
	<200307082027.26233.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
>  Andrew, would you like to pick this patch up for me and forward it
> to Linus after it received some testing in -mm?

It got merged ages ago ;)  Linus simply removed the pure thing.

