Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRCNRs2>; Wed, 14 Mar 2001 12:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131488AbRCNRsS>; Wed, 14 Mar 2001 12:48:18 -0500
Received: from [199.239.160.155] ([199.239.160.155]:9099 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S131481AbRCNRsG>; Wed, 14 Mar 2001 12:48:06 -0500
Date: Wed, 14 Mar 2001 09:46:34 -0800
From: Robert Read <rread@datarithm.net>
To: Greg KH <greg@wirex.com>, Martin Bruchanov <bruchm@pytlik.racom.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010314094634.A16482@tenchi.datarithm.net>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Martin Bruchanov <bruchm@hnilux.racom.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103111706.SAA18394@hnilux.racom.cz> <20010311210309.D19626@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010311210309.D19626@wirex.com>; from greg@wirex.com on Sun, Mar 11, 2001 at 09:03:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2001 at 09:03:09PM -0800, Greg KH wrote:
> On Sun, Mar 11, 2001 at 06:06:24PM +0100, Martin Bruchanov wrote:
> > 
> > Bug report from Martin Bruchanov (bruxy@kgb.cz, bruchm@racom.cz)
> > 
> > ############################################################################
> > [1.] One line summary of the problem:    
> > USB doesn't work properly with SMP kernel on dual-mainboard or with APIC.
> 
> What kind of motherboard is this?
> 

>From the lspci output, looks like I have the same mainboard or at
least one with an identical chipset. I've got an MSI 694D Pro
Mainboard with 694X VIA chipset, with 2 cpus installed, and I had the
same USB problem with 2.4.0, but haven't had time to test it on a
recent kernel.

robert

> And does USB work in SMP mode with "noapic" given on the kernel command
> line?
> 
> thanks,
> 
> greg k-h
> 
> -- 
> greg@(kroah|wirex).com
> http://immunix.org/~greg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
