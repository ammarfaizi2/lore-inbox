Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUHSNyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUHSNyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHSNyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:54:38 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19331 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266169AbUHSNyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:54:37 -0400
Subject: Re: [PATCH] add PCI ROMs to sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
References: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092919910.28129.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 13:51:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-18 at 19:13, Jon Smirl wrote:
> I haven't received any comments on pci-sysfs-rom-17.patch. Is everyone
> asleep or is it ready to be pushed upstream? I'm still not sure that
> anyone has tried it on a ppc machine.

Looks ok to me. Not sure we ever want to copy roms kernel side but thats
a minor query only.

