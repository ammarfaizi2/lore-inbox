Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUIOUHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUIOUHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIOUG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:06:59 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:16525 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267356AbUIOUFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:05:12 -0400
Date: Wed, 15 Sep 2004 21:04:38 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Netdev <netdev@oss.sgi.com>
cc: leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
In-Reply-To: <4148991B.9050200@pobox.com>
Message-ID: <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
References: <4148991B.9050200@pobox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Jeff Garzik wrote:

> Put simply, the "ultimate TOE card" would be a card with network ports, a 
> generic CPU (arm, mips, whatever.), some RAM, and some flash.  This card's 
> "firmware" is the Linux kernel, configured to run as a _totally indepenent 
> network node_, with IP address(es) all its own.
>
> Then, your host system OS will communicate with the Linux kernel running on 
> the card across the PCI bus, using IP packets (64K fixed MTU).

> My dream is that some vendor will come along and implement such a 
> design, and sell it in enough volume that it's US$100 or less. 
> There are a few cards on the market already where implementing this 
> design _may_ be possible, but they are all fairly expensive.

The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI 
card running Linux. Or is that what you were referring to with 
"<cards exist> but they are all fairly expensive."?

> 	Jeff

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
There is nothing so easy but that it becomes difficult when you do it
reluctantly.
 		-- Publius Terentius Afer (Terence)
