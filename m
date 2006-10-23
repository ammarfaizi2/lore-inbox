Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWJWIxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWJWIxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWJWIxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:53:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11475
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751837AbWJWIxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:53:54 -0400
Date: Mon, 23 Oct 2006 01:53:53 -0700 (PDT)
Message-Id: <20061023.015353.30187350.davem@davemloft.net>
To: eiichiro.oiwa.nm@hitachi.com
Cc: greg@kroah.com, alan@redhat.com, jesse.barnes@intel.com,
       linux-kernel@vger.kernel.org, steven.c.cook@intel.com,
       bjorn.helgaas@hp.com, tony.luck@intel.com
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com>
	<20061020.123140.48805752.davem@davemloft.net>
	<XNM1$9$0$4$$3$3$7$A$9002718U453c5dab@hitachi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <eiichiro.oiwa.nm@hitachi.com>
Date: Mon, 23 Oct 2006 15:14:07 +0900

> Ok, I fixed, and tested on x86, x86_64 and IA64 dig.
> Thank you.
> 
> From: David Miller <davem@davemloft.net>
> Signed-off-by: Eiichiro Oiwa <eiichiro.oiwa.nm@hitachi.com>

Greg please apply.
