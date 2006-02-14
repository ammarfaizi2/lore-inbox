Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422818AbWBNV54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWBNV54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWBNV54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:57:56 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59537
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422818AbWBNV5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:57:55 -0500
Date: Tue, 14 Feb 2006 13:58:01 -0800 (PST)
Message-Id: <20060214.135801.04801858.davem@davemloft.net>
To: ralf@linux-mips.org
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, mark.e.mason@broadcom.com
Subject: Re: PCI probe leaves master abort disabled in PCI_BRIDGE_CONTROL
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060214162357.GB21016@linux-mips.org>
References: <20060213.171321.126221906.davem@davemloft.net>
	<20060214051700.GA28721@suse.de>
	<20060214162357.GB21016@linux-mips.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 14 Feb 2006 16:23:57 +0000

> I don't have an affected system at hand, so can't really test but I
> propose something like the below patch.

Looks good to me.
