Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUIPOEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUIPOEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUIPOCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:02:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6598 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268081AbUIPOBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:01:54 -0400
Subject: Re: The ultimate TOE design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Lincoln Dale <ltd@cisco.com>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, paul@clubi.ie,
       netdev@oss.sgi.com, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916133301.GA15562@wotan.suse.de>
References: <20040915141346.5c5e5377.davem@davemloft.net>
	 <4148991B.9050200@pobox.com>
	 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
	 <1095275660.20569.0.camel@localhost.localdomain> <4148A90F.80003@pobox.com>
	 <20040915140123.14185ede.davem@davemloft.net>
	 <20040915210818.GA22649@havoc.gtf.org>
	 <20040915141346.5c5e5377.davem@davemloft.net>
	 <5.1.0.14.2.20040916192213.04240008@171.71.163.14>
	 <1095337159.22739.7.camel@localhost.localdomain>
	 <20040916133301.GA15562@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095339466.22739.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 13:57:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 14:33, Andi Kleen wrote:
> > At 1Ghz the Athlon Geode NX draws about 6W. Thats less than my SCSI
> 
> Are you sure that's worst case, not average? Worst case is usually
> much worse on a big CPU like an Athlon, but the power supply 
> has to be sized for it. 

You are correct - 6W average 9W TDP, still less than my scsicontroller
8)

