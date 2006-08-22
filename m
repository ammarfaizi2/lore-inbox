Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWHVIXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWHVIXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWHVIXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:23:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:697
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932132AbWHVIXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:23:37 -0400
Date: Tue, 22 Aug 2006 01:23:41 -0700 (PDT)
Message-Id: <20060822.012341.57449506.davem@davemloft.net>
To: nmiell@comcast.net
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       akpm@osdl.org, netdev@vger.kernel.org, zach.brown@oracle.com,
       hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1156234672.8055.51.camel@entropy>
References: <1156230051.8055.27.camel@entropy>
	<20060822072448.GA5126@2ka.mipt.ru>
	<1156234672.8055.51.camel@entropy>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Miell <nmiell@comcast.net>
Date: Tue, 22 Aug 2006 01:17:52 -0700

> Is any of this documented anywhere? I'd think that any new userspace
> interfaces should have man pages explaining their use and some example
> code before getting merged into the kernel to shake out any interface
> problems.

Get real.

Nobody made this requirement for things like splice() et al.

I think people are being mostly very unreasonable in the
demands they are making upon Evgeniy.  It will only serve
to discourage the one person who is doing work to solve
these problems.

