Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUJVVeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUJVVeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268025AbUJVVa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:30:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:36066 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267904AbUJVVaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:30:25 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Timothy Miller <miller@techsource.com>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41797103.2070005@pobox.com>
References: <4176E08B.2050706@techsource.com>
	 <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net>
	 <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com>
	 <417955D3.5020206@pobox.com> <41795DEA.8050309@techsource.com>
	 <41796083.9060301@pobox.com> <417965E7.8010408@techsource.com>
	 <41797103.2070005@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098476845.19435.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 21:27:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-22 at 21:43, Jeff Garzik wrote:
> engineers to write a complex 3D driver from scratch.  If your company 
> _leads the industry_ in creating a standardized interface, doesn't 
> everybody benefit?

Not always - sometimes you win (Soundblaster, IBM PC) and sometimes you
lose. Often you only win if you have a quality differentiator so you can
sneer at the opposition and use words like "PC clone" and
"Soundblaster compatible"

> Another advantage is that a simple "do GL" interface is much more 
> "future-proof" interface, since it is a very high level interface.

Not really, we are heading towards real time raytrace and the hardware
and low level changes dramatically for that (including wanting to do non
light traces for audio mixing, explosion models etc)

Alan

