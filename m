Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTFLQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTFLQ4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:56:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:5769 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264900AbTFLQ4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:56:18 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 12 Jun 2003 10:08:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Marc Sowen <marc.sowen@tu-harburg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel PRO/Wireless 2100 vs. Broadcom BCM9430x
In-Reply-To: <001101c330f5$771bd7a0$0101230a@apollo>
Message-ID: <Pine.LNX.4.55.0306120957260.3626@bigblue.dev.mcafeelabs.com>
References: <001101c330f5$771bd7a0$0101230a@apollo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, Marc Sowen wrote:

> Hi everybody,
>
> I hope this is not too off-topic, but the fact is that neither the Intel
> PRO/Wireless 2100 (Centrino) chipset nor the Broadcom BCM9430x (e.g.
> Dell Truemobile 1180/1300/1400) chipset is currently supported in Linux
> due to FCC regulation problems.
>
> Anyhow, I plan to get a new Notebook within the next 2 or 3 weeks and I
> need to decide, whether to go for the Intel PRO/Wireless 2100 or the
> Broadcom BCM9430x chipset. I know it's hard to say, but what do you
> think, which company (Intel or Broadcom) is more likely to release the
> necessary documents and/or drivers for their chipsets? Both companys
> seem to ignore all inquiries concerning Linux support at the moment.

I used to win the "Dumb context 2003" by buying a laptop w/out checking
the hw compatibility list. It was first sight love :) Now after a series
of custom patches (SiS chipset, pcmcia irq selection, local apic,...)
everything is working fine but the Broadcom integrated WLAN. I suggest you
to go with a machine w/out the integrated WLAN and then buy a supported
pcmcia card (orinoco prismII works great on my machine). To understand who
between Intel and Broadcom will first release specs, take a look at their
web sites for documentation/specs. The answer will become pretty easy.



- Davide

