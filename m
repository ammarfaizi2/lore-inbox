Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTFLRJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTFLRJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:09:20 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:60314 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264906AbTFLRIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:08:15 -0400
Subject: Re: Intel PRO/Wireless 2100 vs. Broadcom BCM9430x
From: Disconnect <lkml@sigkill.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0306120957260.3626@bigblue.dev.mcafeelabs.com>
References: <001101c330f5$771bd7a0$0101230a@apollo>
	 <Pine.LNX.4.55.0306120957260.3626@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Message-Id: <1055438520.11780.36.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 12 Jun 2003 13:22:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 13:08, Davide Libenzi wrote:
> On Thu, 12 Jun 2003, Marc Sowen wrote:
> > Hi everybody,
> >
> > I hope this is not too off-topic, but the fact is that neither the Intel
> > PRO/Wireless 2100 (Centrino) chipset nor the Broadcom BCM9430x (e.g.
> > Dell Truemobile 1180/1300/1400) chipset is currently supported in Linux
> > due to FCC regulation problems.
> >
> > Anyhow, I plan to get a new Notebook within the next 2 or 3 weeks and I
> > need to decide, whether to go for the Intel PRO/Wireless 2100 or the
> > Broadcom BCM9430x chipset. I know it's hard to say, but what do you
> > think, which company (Intel or Broadcom) is more likely to release the
> > necessary documents and/or drivers for their chipsets? Both companys
> > seem to ignore all inquiries concerning Linux support at the moment.
> 
> I used to win the "Dumb context 2003" by buying a laptop w/out checking
> the hw compatibility list. It was first sight love :) Now after a series
> of custom patches (SiS chipset, pcmcia irq selection, local apic,...)
> everything is working fine but the Broadcom integrated WLAN. I suggest you
> to go with a machine w/out the integrated WLAN and then buy a supported
> pcmcia card (orinoco prismII works great on my machine). To understand who
> between Intel and Broadcom will first release specs, take a look at their
> web sites for documentation/specs. The answer will become pretty easy.

Find out which one is in that linksys possible-gpl-violation and use
that one.  (I think its broadcom.) 

FWIW I got my laptop with the broadcom (dell truemobile) intentionally,
as it is useful under XP and might eventually work under Linux.  (Then I
bought the older truemobile, the 1150 I think, for $80 or so. Swapped
right in, leaving the pcmcia slot for my ipaq's hdd, etc.  Even the
Fn-wireless button correctly turns the radio on/off, although Linux has
no way to detect it except loss of signal.)

-- 
Disconnect <lkml@sigkill.net>

