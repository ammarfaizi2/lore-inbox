Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264206AbUENFGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUENFGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:06:07 -0400
Received: from fmr11.intel.com ([192.55.52.31]:6361 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264184AbUENFGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:06:03 -0400
Subject: Re: IRQ and PCI and (2.6.6-bk1 + some bk trees from -mm1)
From: Len Brown <len.brown@intel.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB528@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB528@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084511147.12353.247.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 May 2004 01:05:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 13 May 2004, Grzegorz Kulewski wrote:
> 
> > First I cannot boot without acpi_irq_balance.


>  polb01 ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7  10 11 12 14
> 15) *9

Please let me know if this patch does not address the problem:

http://lkml.org/lkml/2004/5/11/175

Note that it is included in 2.6.6-mm2

thanks,
-Len


