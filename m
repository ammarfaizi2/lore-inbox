Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272767AbTHPLQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 07:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272772AbTHPLQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 07:16:39 -0400
Received: from [66.212.224.118] ([66.212.224.118]:6419 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272767AbTHPLQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 07:16:38 -0400
Date: Sat, 16 Aug 2003 07:04:44 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg Kroah-Hartmann <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: RE: Update MSI Patches
In-Reply-To: <Pine.LNX.4.53.0308160053380.19482@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308160631321.2008@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E50240154170D@orsmsx404.jf.intel.com>
 <Pine.LNX.4.53.0308160053380.19482@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, Zwane Mwaikambo wrote:

> I think a variable rename should be fine, as long as the reader doesn't 
> get misled into thinking a specific variable is something which it isn't. 
> index sounds fine to me, the nice thing about your patch is that we don't 
> have to touch pci_dev->irq at all. The only other change would be what to 
> show to userspace e.g. driver prints pci_dev->irq and /proc/interrupts 
> prints vector. But that's all secondary...

Wait ignore that last comment, i just saw arch/i386/pci/irq.c

	Zwane

