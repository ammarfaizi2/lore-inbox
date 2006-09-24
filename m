Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWIXRZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWIXRZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIXRZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:25:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:43748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751226AbWIXRZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:25:55 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.19 -mm merge plans
From: Mike Galbraith <efault@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, davidsen@tmr.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060924092010.GC17639@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	 <45130533.2010209@tmr.com> <45130527.1000302@garzik.org>
	 <20060921.145208.26283973.davem@davemloft.net>
	 <20060921220539.GL26683@redhat.com>
	 <20060922083542.GA4246@flint.arm.linux.org.uk>
	 <20060922154816.GA15032@redhat.com>
	 <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
	 <20060924074837.GB13487@xi.wantstofly.org>
	 <20060924092010.GC17639@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 19:38:26 +0000
Message-Id: <1159126706.6098.18.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 10:20 +0100, Russell King wrote:

> The point I'm making is that for some things, keeping the changes as
> patches until they're ready is far easier, more worthwhile and flexible
> than having them simmering in some git tree somewhere.

I <heart> patch and </heart> scm (works for me:), but in theory, isn't
that the same?

