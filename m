Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263190AbVG3XcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbVG3XcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbVG3XcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:32:11 -0400
Received: from tim.rpsys.net ([194.106.48.114]:22740 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S263190AbVG3XbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:31:18 -0400
Subject: Re: Heads up for distro folks: PCMCIA hotplug differences (Re:
	-rc4: arm broken?)
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Grant Coady <lkml@dodo.com.au>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050730232652.P26592@flint.arm.linux.org.uk>
References: <20050730130406.GA4285@elf.ucw.cz>
	 <1122741937.7650.27.camel@localhost.localdomain>
	 <20050730201508.B26592@flint.arm.linux.org.uk>
	 <20050730223628.M26592@flint.arm.linux.org.uk>
	 <7pune19t9m9cgdacv8b5r3djpqvk28nipu@4ax.com>
	 <20050730232652.P26592@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 31 Jul 2005 00:31:10 +0100
Message-Id: <1122766271.7650.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 23:26 +0100, Russell King wrote:
> No.  You can still use cardctl (or whatever the pcmciautils version
> of that is) to eject cards, and you can of course still pull them
> from the socket.

If you pull CF memory cards from the socket, you'll see some interesting
oops. I've been waiting for things to stabilise a bit before trying to
investigate and hopefully fix this. Any assistance welcome.

Richard

