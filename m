Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWGHOof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWGHOof (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 10:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWGHOof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 10:44:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:58596 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964860AbWGHOoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 10:44:34 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<44AD680B.9090603@unsolicited.net> <20060706221747.GA2632@kroah.com>
	<44AECDF8.4020702@unsolicited.net>
	<1152368380.3408.8.camel@pim.off.vrfy.org>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 16:44:32 +0200
In-Reply-To: <1152368380.3408.8.camel@pim.off.vrfy.org>
Message-ID: <p73ejwwnokv.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> writes:

> On Fri, 2006-07-07 at 22:11 +0100, David R wrote:
> > Greg KH wrote:
> > > right?  Please file a bug at bugzilla.novell.com and the SuSE people can
> > 
> > Done. I may also try to chase down any divergence in the udev/hal scripts the
> > weekend. Not a massive deal anyhow, I can always chown the device if I need
> > the scanner. It all works just fine.
> 
> It's a bug in HAL, that feeds resmgr to grand access to the local user.
> It should be fixed soon.

I hope you mean in the kernel or did user space compatibility get
broken again?

-Andi
