Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVFSS4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVFSS4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFSS4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:56:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261178AbVFSS4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:56:12 -0400
Date: Sun, 19 Jun 2005 19:56:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050619195607.C13005@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <1119134359.7675.38.camel@localhost.localdomain> <20050619001841.A7252@flint.arm.linux.org.uk> <1119144048.7675.101.camel@localhost.localdomain> <20050619100226.A6499@flint.arm.linux.org.uk> <20050619101120.B6499@flint.arm.linux.org.uk> <1119201158.7554.2.camel@localhost.localdomain> <20050619183928.B13005@flint.arm.linux.org.uk> <1119205560.7554.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1119205560.7554.10.camel@localhost.localdomain>; from rpurdie@rpsys.net on Sun, Jun 19, 2005 at 07:25:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 07:25:59PM +0100, Richard Purdie wrote:
> On Sun, 2005-06-19 at 18:39 +0100, Russell King wrote:
> > Next batched smp patch can be found at www.home.arm.../~rmk/nightly
> > which I'm currently planning to go to Linus tonight.
> 
> I applied smp-20050619.patch to 2.6.12-rc6-mm1 + the last fix and the
> Zaurus seems perfectly happy with it. Let me know as and when you have
> further releases that need testing (a message to linux-arm-kernel might
> be the best way to announce them?).

Thanks for testing.  Most of the other patches are platform specific
so this may not be required.  However, if there are other changes to
non-platform specific, I'll try to point them out a couple of days
before they get merged.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
