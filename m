Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRCVJc1>; Thu, 22 Mar 2001 04:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131954AbRCVJcR>; Thu, 22 Mar 2001 04:32:17 -0500
Received: from www.inreko.ee ([195.222.18.2]:35318 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131949AbRCVJcH>;
	Thu, 22 Mar 2001 04:32:07 -0500
Date: Thu, 22 Mar 2001 11:44:57 +0200
From: Marko Kreen <marko@l-t.ee>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: Omar Kilani <ok@mailcall.com.au>, Dalton Calford <dcalford@distributel.ca>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec/DPT RAID Drivers [Was: Re: DPT Driver Status]
Message-ID: <20010322114457.A30008@l-t.ee>
In-Reply-To: <5.0.2.1.2.20010316021553.01c71480@172.17.0.107> <Pine.LNX.4.30.0103212125220.28905-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0103212125220.28905-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Wed, Mar 21, 2001 at 09:27:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 09:27:47PM -0800, Dr. Kelsey Hudson wrote:
> I've got a SmartCACHE IV...This driver seems not to recognize it.

It is not supposed to.  For DPT .* I - IV use CONFIG_SCSI_EATA
'EATA ISA/EISA/PCI (DPT and generic EATA/DMA-compliant boards)'
option.


-- 
marko

