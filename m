Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267423AbUJIVf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUJIVf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUJIVf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:35:59 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:32985 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S267423AbUJIVf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:35:57 -0400
Subject: Re: [KJ] [RFT 2.6] pci-gart.c replace pci_find_device with
	pci_get_device
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hanna Linder <hannal@us.ibm.com>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, ak@suse.de,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com
In-Reply-To: <20041009181859.GW16153@parcelfarce.linux.theplanet.co.uk>
References: <87680000.1097276112@w-hlinder.beaverton.ibm.com>
	 <1097342134.3903.14.camel@sfeldma-mobl2.dsl-verizon.net>
	 <20041009181859.GW16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1097354748.6579.0.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 09 Oct 2004 14:35:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 11:18, Matthew Wilcox wrote:
> > for_each_pci_dev?
> 
> for_each_pci_dev() doesn't take a VENDOR/DEVICE ID pair.
> I think this is a mistake.

You're right, my bad.

-scott

