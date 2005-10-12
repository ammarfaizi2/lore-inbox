Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbVJLSiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbVJLSiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJLSiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 14:38:50 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:13495 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S1751500AbVJLSis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 14:38:48 -0400
Date: Wed, 12 Oct 2005 19:38:13 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: Kai Svahn <kai.svahn@nokia.com>
Cc: ext Jon Masters <jonathan@jonmasters.org>,
       Tony Lindgren <tony@atomide.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nokia 770 kernel sources?
Message-ID: <20051012183813.GC24120@apogee.jonmasters.org>
References: <35fb2e590510101708l497a44a5oe71971e9c3c925a9@mail.gmail.com> <20051011134936.GA12462@atomide.com> <20051011135739.GA22484@apogee.jonmasters.org> <1129133327.22381.29.camel@six.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129133327.22381.29.camel@six.research.nokia.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:08:47PM +0300, Kai Svahn wrote:

> The kernel sources for N770 will be available in www.maemo.org when we
> start sales. There will be some binary modules that will not be made
> open source. All drivers we can open source, we will, and they will be
> pushed to linux-omap tree and into mainstream kernel through driver
> specific channels. Unfortunately all open source drivers are not yet in
> linux-omap tree so you cannot compile your own kernel for N770, I'm
> sorry about that.

Sure thing. I'm actually just trying to be helpful since I'm pretty
experienced at debugging kernels and noticed a few issues with the VM on
the unit I have - guess I'll have to wait before I can debug those -
there's also a couple of problems with the audio driver.

There's a suspicious looking connector in the battery compartment that
might well be JTAG. In any case, I'm confident that if I actually opened
this unit I could figure out the changes you've made to the reference OMAP.
But I'll wait because I don't want to take this unit apart :-)

Jon.
