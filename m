Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVFGTdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVFGTdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVFGTdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:33:00 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:38417 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261629AbVFGTcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:32:55 -0400
Date: Tue, 7 Jun 2005 21:33:05 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
Message-ID: <20050607193305.GN2369@mail.muni.cz>
References: <20050607181300.GL2369@mail.muni.cz> <42A5EC7C.4020202@pobox.com> <20050607185845.GM2369@mail.muni.cz> <42A5F51B.5060909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A5F51B.5060909@pobox.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 03:27:23PM -0400, Jeff Garzik wrote:
> >Bus  2, device   3, function  0:
> >    Ethernet controller: PCI device 1425:0006 (ASIC Designers Inc) (rev 0).
> >      IRQ 24.
> >      Master Capable.  Latency=248.  
> >      Non-prefetchable 64 bit memory at 0xf6042000 [0xf6042fff].
> >
> >
> >kernel 2.6.6 and driver from web site:
> >Chelsio TOE Network Driver - version 2.1.0
> >eth0: Chelsio T110 1x10GBaseX TOE (rev 1), PCIX 100MHz/64-bit
> >eth0: 512MB SDRAM, 128MB FCRAM
> 
> I can't help much beyond this then :(  There should be Chelsio email 
> addresses in the driver...

I'am afraid that they oficially support only 2.6.6 kernel :(

I wonder whether this driver works for someone. If not, it should be removed.

And also, who does it maintain?

-- 
Luká¹ Hejtmánek
