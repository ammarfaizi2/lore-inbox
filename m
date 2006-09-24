Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWIXV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIXV5O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWIXV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:57:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751628AbWIXV5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:57:12 -0400
Date: Sun, 24 Sep 2006 14:56:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org,
       Petr Baudis <pasky@suse.cz>
Subject: Re: 2.6.18-mm1
Message-Id: <20060924145656.1a867b20.akpm@osdl.org>
In-Reply-To: <20060924213422.GD12795@flint.arm.linux.org.uk>
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<20060924124647.GB25666@flint.arm.linux.org.uk>
	<20060924132213.GE11916@pasky.or.cz>
	<20060924142005.GF25666@flint.arm.linux.org.uk>
	<20060924142958.GU13132@pasky.or.cz>
	<20060924144710.GG25666@flint.arm.linux.org.uk>
	<7veju185j9.fsf@assigned-by-dhcp.cox.net>
	<20060924213422.GD12795@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 22:34:22 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> akpm - I'm afraid the ARM devel tree has been regenerated almost from
> scratch, so you might encouter some issues next time you pull it.

It turns out that this sort of thing is a non-issue for me.  I very
frequently get the does-not-fast-forward thing, so I just blow the branch
away and repull.

In fact for a while I was doing a `git-branch -D' against _every_ tree
prior to pulling it, but I turned that off for some reason.
