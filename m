Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbTICSP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTICSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:14:28 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63180 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264191AbTICSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:12:42 -0400
Subject: Re: Scaling noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903173213.GC5769@work.bitmover.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
	 <20030903173213.GC5769@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062612665.19982.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 19:11:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 18:32, Larry McVoy wrote:
> For a lot of applications we are.  Go talk to your buddies in the processor
> group, I think there is a fair amount of awareness that for most apps faster
> processors aren't doing any good.  Ditto for SMP.

>From the app end I found similar things. My gnome desktop performance
doesn't measurably improve beyond about 7-800Mhz. Some other stuff like
mozilla benefits from more CPU and 3D game stuff can burn all it can
get.

Disk matters a great deal (especially seek performance although there is
a certain amount of bad design in the kernel/desktop also involved
there) and memory bandwidth also seems to matter sometimes.


