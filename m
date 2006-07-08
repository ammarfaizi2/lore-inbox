Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWGHOTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWGHOTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWGHOTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:19:40 -0400
Received: from soundwarez.org ([217.160.171.123]:23714 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964852AbWGHOTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:19:40 -0400
Subject: Re: Linux v2.6.18-rc1
From: Kay Sievers <kay.sievers@vrfy.org>
To: David R <david@unsolicited.net>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44AECDF8.4020702@unsolicited.net>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <44AD680B.9090603@unsolicited.net> <20060706221747.GA2632@kroah.com>
	 <44AECDF8.4020702@unsolicited.net>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 16:19:40 +0200
Message-Id: <1152368380.3408.8.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 22:11 +0100, David R wrote:
> Greg KH wrote:
> > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> 
> Done. I may also try to chase down any divergence in the udev/hal scripts the
> weekend. Not a massive deal anyhow, I can always chown the device if I need
> the scanner. It all works just fine.

It's a bug in HAL, that feeds resmgr to grand access to the local user.
It should be fixed soon.

Thanks,
Kay

