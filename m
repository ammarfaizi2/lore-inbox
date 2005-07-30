Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVG3WSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVG3WSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbVG3WSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:18:22 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:43152 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S263105AbVG3WRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:17:45 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re: -rc4: arm broken?)
Date: Sun, 31 Jul 2005 08:17:29 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <7pune19t9m9cgdacv8b5r3djpqvk28nipu@4ax.com>
References: <20050730130406.GA4285@elf.ucw.cz> <1122741937.7650.27.camel@localhost.localdomain> <20050730201508.B26592@flint.arm.linux.org.uk> <20050730223628.M26592@flint.arm.linux.org.uk>
In-Reply-To: <20050730223628.M26592@flint.arm.linux.org.uk>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005 22:36:28 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>Let me qualify that, because it's not 100% fine due to the changes in
>PCMCIA land.
>
>Since PCMCIA cards are detected and drivers bound at boot time, we no

Without an unbind/eject option?  Implies reboot to remove a device...

Grant.

