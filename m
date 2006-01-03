Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWACUUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWACUUv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWACUUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:20:50 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52365
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750913AbWACUUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:20:50 -0500
Date: Tue, 03 Jan 2006 12:18:01 -0800 (PST)
Message-Id: <20060103.121801.18743523.davem@davemloft.net>
To: trizt@iname.com
Cc: mark@mtfhpc.demon.co.uk, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0601031456240.25341@lai.local.lan>
References: <Pine.LNX.4.64.0512121127240.12856@lai.local.lan>
	<20051212.142654.62759069.davem@davemloft.net>
	<Pine.LNX.4.64.0601031456240.25341@lai.local.lan>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Tue, 3 Jan 2006 15:01:09 +0100 (CET)

> After a small chat at #Gentoo-Sparc at freenode, I thought that I should 
> just say that the problem with X locking up is still there (15-rc7), 
> regardless of gcc version, and that the problem has to do with the UPA 
> code according those who know a lot more than I do.

What "UPA code"?

We don't even have so much as a UPA driver in the Linux kernel.
So it's hard to know what is being spoken about.  Maybe something
in the X server?

Perhaps these experts should explain :-)
