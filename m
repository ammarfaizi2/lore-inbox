Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUHXQrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUHXQrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268123AbUHXQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:46:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39440 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268114AbUHXQqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:46:50 -0400
Date: Tue, 24 Aug 2004 17:46:42 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040824174642.G7738@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <412B6FD6.2050105@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412B6FD6.2050105@drzeus.cx>; from drzeus-list@drzeus.cx on Tue, Aug 24, 2004 at 06:41:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 06:41:58PM +0200, Pierre Ossman wrote:
> The MMC patches included in 2.6.9-rc1 missed drivers/Kconfig.

Not really.  The presently supported MMC interfaces only exist on ARM,
and ARM doesn't use drivers/Kconfig.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
