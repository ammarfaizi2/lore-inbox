Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFSS0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFSS0N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFSS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:26:12 -0400
Received: from tim.rpsys.net ([194.106.48.114]:35250 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261279AbVFSS0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:26:09 -0400
Subject: Re: 2.6.12-rc6-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050619183928.B13005@flint.arm.linux.org.uk>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	 <1119134359.7675.38.camel@localhost.localdomain>
	 <20050619001841.A7252@flint.arm.linux.org.uk>
	 <1119144048.7675.101.camel@localhost.localdomain>
	 <20050619100226.A6499@flint.arm.linux.org.uk>
	 <20050619101120.B6499@flint.arm.linux.org.uk>
	 <1119201158.7554.2.camel@localhost.localdomain>
	 <20050619183928.B13005@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 19 Jun 2005 19:25:59 +0100
Message-Id: <1119205560.7554.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-19 at 18:39 +0100, Russell King wrote:
> Good.  Fix committed.

Thanks.

> Next batched smp patch can be found at www.home.arm.../~rmk/nightly
> which I'm currently planning to go to Linus tonight.

I applied smp-20050619.patch to 2.6.12-rc6-mm1 + the last fix and the
Zaurus seems perfectly happy with it. Let me know as and when you have
further releases that need testing (a message to linux-arm-kernel might
be the best way to announce them?).

Richard

