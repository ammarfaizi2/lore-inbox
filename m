Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUJXQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUJXQkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbUJXQkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 12:40:08 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:63366 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S261543AbUJXQiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 12:38:14 -0400
Date: Sun, 24 Oct 2004 19:36:47 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (update)
In-Reply-To: <200410231955.22819.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0410241936110.3001@musoma.fsmlabs.com>
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org>
 <200410231909.09931.rjw@sisk.pl> <200410231955.22819.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Rafael J. Wysocki wrote:

> It happened again, on 2.6.9-mm1, and this time the network adapter stopped 
> working along with the USB (like on 2.6.10-rc1).  I unloaded the ohci-hcd, 
> ehci-hcd and sk98lin modules and loaded them again, and this apparently _did_ 
> help.
> 
> I'm attaching the "fresh" output of dmesg (the "IRQ INTR_SF lossage" message 
> from ohci_hcd looks suspiciously to me).

Can you please send me /var/log/dmesg the logs you're sending aren't 
complete.

Thanks,
	Zwane

