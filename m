Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVLPIKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVLPIKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 03:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVLPIKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 03:10:11 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:46951 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932175AbVLPIKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 03:10:10 -0500
X-IronPort-AV: i="3.99,260,1131343200"; 
   d="scan'208"; a="353966956:sNHT27323140"
Date: Fri, 16 Dec 2005 02:10:09 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216081009.GA12167@lists.us.dell.com>
References: <20051216052054.83256.qmail@web50209.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216052054.83256.qmail@web50209.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:20:54PM -0800, Alex Davis wrote:
> The problem is that, with laptops, most of the time you DON'T have a choice:
> HP and Dell primarily use a Broadcomm integrated wireless card in ther products.
> As of yet, there is no open source driver for Broadcomm wireless.
> 
> >If 8k stacks get removed, yes. So if you have a chance to choose don't buy a 
> >wifi card which doesn't have a native linux driver.

Dell "Software & Peripherals" sells "customer kits" of the Intel
ipw2915 for $59 US, so even if you bought the "wrong" wireless NIC
when you bought the laptop, this can be remedied.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
