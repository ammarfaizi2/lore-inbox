Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267443AbUHRSjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267443AbUHRSjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267472AbUHRSjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:39:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30679 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267443AbUHRSjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:39:05 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Wed, 18 Aug 2004 14:37:06 -0400
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
In-Reply-To: <20040818181310.12047.qmail@web14927.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181437.06887.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 18, 2004 2:13 pm, Jon Smirl wrote:
> I haven't received any comments on pci-sysfs-rom-17.patch. Is everyone
> asleep or is it ready to be pushed upstream? I'm still not sure that
> anyone has tried it on a ppc machine.
>
> Since it's small I'll attach it again for your convenience.

Works for me on ia64.  Greg, is this one ready for your queue?

Thanks,
Jesse
