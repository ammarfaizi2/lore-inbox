Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCTQBK>; Thu, 20 Mar 2003 11:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbTCTQBK>; Thu, 20 Mar 2003 11:01:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23517 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261584AbTCTQBJ>; Thu, 20 Mar 2003 11:01:09 -0500
Date: Thu, 20 Mar 2003 08:11:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@wildopensource.com>
cc: Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <9590000.1048176717@[10.10.2.4]>
In-Reply-To: <20030320160440.A14435@infradead.org>
References: <14240000.1048146629@[10.10.2.4]> <m365qenioq.fsf@trained-monkey.org> <20030320160440.A14435@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.9 of course has the newstyle pci interface! And actual hotplug
> PCI support also is in all today singnificant 2.4.9 forks (RH..).
> 
> There's even some shim to emulate the pci_driver style interface on
> 2.2.
> 
> Anyway, this table has another use, it's used by userland ools like
> installers for selecting the right driver for a given pci device.  So
> even if it seems unused from kernelspace it has a use.

Are they kmem diving? Or parsing source code? 

Thanks,

M.
