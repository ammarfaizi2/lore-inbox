Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVGFT54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVGFT54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVGFT5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:57:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:58288 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262205AbVGFPz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:55:59 -0400
Date: Wed, 6 Jul 2005 08:55:56 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2
Message-ID: <20050706155556.GB13115@kroah.com>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <42CB8088.1090508@ppp0.net> <Pine.LNX.4.58.0507060832380.3570@g5.osdl.org> <42CBFE61.9030308@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CBFE61.9030308@ppp0.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 05:53:05PM +0200, Jan Dittmer wrote:
> Linus Torvalds wrote:
> > 
> > On Wed, 6 Jul 2005, Jan Dittmer wrote:
> > 
> >>Linus Torvalds wrote:
> >>
> >>>Ok,
> >>> -rc3 is pretty small, with the bulk of the diff being some defconfig
> >>
> >>...
> >>
> >>>Linus Torvalds:
> >>>  Linux v2.6.13-rc3
> >>
> >>Confused?!
> > 
> > 
> > Constantly.
> > 
> > Let's hope that commit naming bug was the worst part of the release..
> 
> Nah, compared to git7 you (or greg?) managed to break alpha, sparc and x86_64.

This was a CONFIG_HOTPLUG issue, I'll fix it in a bit...

thanks,

greg k-h
