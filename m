Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJWHHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJWHHp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJWHHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:07:45 -0400
Received: from daffy.napanet.net ([206.81.96.18]:61707 "EHLO mx1.napanet.net")
	by vger.kernel.org with ESMTP id S261875AbUJWHHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:07:41 -0400
Date: Sat, 23 Oct 2004 00:06:14 -0700
From: Stephen Lewis <lewis@napanet.net>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-Id: <20041023000614.6ca68c2e.lewis@napanet.net>
In-Reply-To: <200410230045.49517.gene.heskett@verizon.net>
References: <20041022101529.732254eb.lewis@napanet.net>
	<200410230045.49517.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.8; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 00:45:49 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

...
> >Baseline - I can get accelerated 3D graphics and video overlay
> >and YV12 and VGA registers with open source driver that compiles
> >for PowerPC and DEC Alpha today for $85 - Radeon 7500 PCI.
> 
> 'scuse me, but have you tried to buy one of those locally?  The 
> unwashed masses of us are stuck with whatever we can buy at Circuit 
> City et all, and the cheapest thing today for an AGP slot is the 
> house brands of the 9200 SE w/128 megs of ddr ram.

What do you have against eBay?

>...
> Has this links code been substantially updated since the 6.8.1 release 
> as built on an x86 system?  If not, then this common readily 
> available card is still not supported all that well, my lspci outputs 
> say the vendor codes are unknown.  And my glxgears is 198 fps.
> 

Sorry I have no x86 systems.
9200SE is listed as 3d accelerated see here:
http://freedesktop.org/~xorg/X11R6.8.0/doc/radeon.4.html
maybe you do not have dri loaded?

> -- 
> Cheers, Gene

Stephen Lewis
