Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUIPNYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUIPNYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268058AbUIPNYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:24:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53189 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268053AbUIPNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:23:56 -0400
Subject: Re: The ultimate TOE design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lincoln Dale <ltd@cisco.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       paul@clubi.ie, netdev@oss.sgi.com, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20040916192213.04240008@171.71.163.14>
References: <20040915141346.5c5e5377.davem@davemloft.net>
	 <4148991B.9050200@pobox.com>
	 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	 <1095275660.20569.0.camel@localhost.localdomain> <4148A90F.80003@pobox.com>
	 <20040915140123.14185ede.davem@davemloft.net>
	 <20040915210818.GA22649@havoc.gtf.org>
	 <20040915141346.5c5e5377.davem@davemloft.net>
	 <5.1.0.14.2.20040916192213.04240008@171.71.163.14>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095337159.22739.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 13:19:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 10:29, Lincoln Dale wrote:
> . . . this ignore the realities of power restrictions of PCI today . . .
> sure, one could create a PCI card that takes a power-connector, but that 
> don't scale so well either . . .

At 1Ghz the Athlon Geode NX draws about 6W. Thats less than my SCSI
controller. I'm sure its not co-incidence that powerpc shows up on such
boards a lot more than x86 however.


