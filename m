Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTH0NvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTH0NvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:51:12 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:33440 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262622AbTH0NvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:51:11 -0400
Subject: Re: KDB in the mainstream 2.4.x kernels?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Greg Stark <gsstark@mit.edu>, Martin Pool <mbp@sourcefrog.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030825162303.GA7288@averell>
References: <aJIn.3mj.15@gated-at.bofh.it>
	 <m3smp3y38y.fsf@averell.firstfloor.org>
	 <pan.2003.08.13.04.40.27.59654@sourcefrog.net>
	 <20030813110453.GA26019@colin2.muc.de> <87y8xiexue.fsf@stark.dyndns.tv>
	 <20030825162303.GA7288@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061992194.22739.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 14:49:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-25 at 17:23, Andi Kleen wrote:
> > instructions as a forth program that frobbed registers appropriately. The
> > kernel would have a small forth interpretor to run it. Then switching
> > resolutions could happen safely in the kernel.
> 
> Did the proposal come with working code?

I've seen workable non forth versions of the proposal yes. It isnt 
actually that hard to do for most video cards 

