Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264776AbUEOXev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbUEOXev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 19:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUEOXeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 19:34:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56504 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264776AbUEOXet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 19:34:49 -0400
Date: Sun, 16 May 2004 01:34:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolas Pitre <nico@cam.org>
Cc: Todd Poynor <tpoynor@mvista.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
Message-ID: <20040515233448.GB30489@atrey.karlin.mff.cuni.cz>
References: <20040514025053.GA14773@elf.ucw.cz> <Pine.LNX.4.44.0405142129470.15495-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405142129470.15495-100000@xanadu.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In case of that dual-core CPU, does linux really run on both CPUs?
> 
> No, only one of them.  One is usually an ARM core which runs Linux while the
> other is a DSP.

Ahha, I originaly thought that it is 2 arms, each of them with DSP
capabilities (MMX-like). Thanks.

> > Do we get sources for GSM network stack, too?
> 
> Since they run on the DSP then probably not.

Ok, even without DSP sources it should be possible to create usefull
NetMonitor, but we'll probably not be able to turn phones into two-way
radios... Good.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
