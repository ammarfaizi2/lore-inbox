Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUJXUSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUJXUSU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUJXUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:18:19 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:656 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261632AbUJXUSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:18:06 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1: NForce3 problem (update)
Date: Sun, 24 Oct 2004 22:19:56 +0200
User-Agent: KMail/1.6.2
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
References: <200410222354.44563.rjw@sisk.pl> <200410231955.22819.rjw@sisk.pl> <Pine.LNX.4.61.0410241936110.3001@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0410241936110.3001@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410242219.56368.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 of October 2004 18:36, Zwane Mwaikambo wrote:
> On Sat, 23 Oct 2004, Rafael J. Wysocki wrote:
> 
> > It happened again, on 2.6.9-mm1, and this time the network adapter stopped 
> > working along with the USB (like on 2.6.10-rc1).  I unloaded the ohci-hcd, 
> > ehci-hcd and sk98lin modules and loaded them again, and this apparently 
_did_ 
> > help.
> > 
> > I'm attaching the "fresh" output of dmesg (the "IRQ INTR_SF lossage" 
message 
> > from ohci_hcd looks suspiciously to me).
> 
> Can you please send me /var/log/dmesg the logs you're sending aren't 
> complete.

Er, I have no /var/log/dmesg (SuSE 9.1 x86_64).  I just do "dmesg > file" and 
that's what I'm sending.  Can you tell me, please, what exactly is missing 
from the logs and what I shoud do to make it be there?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
