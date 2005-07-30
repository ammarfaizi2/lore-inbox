Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263130AbVG3TSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbVG3TSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbVG3TRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:17:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65041 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263122AbVG3TPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:15:17 -0400
Date: Sat, 30 Jul 2005 20:15:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: -rc4: arm broken?
Message-ID: <20050730201508.B26592@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1122741937.7650.27.camel@localhost.localdomain>; from rpurdie@rpsys.net on Sat, Jul 30, 2005 at 05:45:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 05:45:37PM +0100, Richard Purdie wrote:
> On Sat, 2005-07-30 at 15:04 +0200, Pavel Machek wrote:
> > I merged -rc4 into my zaurus tree, and now zaurus will not boot. I see
> > oops-like display, and it seems to be __call_usermodehelper /
> > do_execve / load_script related. Anyone seen it before?
> 
> For the record -rc4 works fine on my Zaurus c760 (which is pxa255 based
> rather than sa1100).

It appears to work fine on Intel Assabet.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
