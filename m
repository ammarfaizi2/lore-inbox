Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWGaEFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWGaEFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWGaEFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:05:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44702 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751238AbWGaEFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:05:14 -0400
Date: Sun, 30 Jul 2006 21:00:45 -0700
From: Greg KH <greg@kroah.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
Subject: Re: [PATCH 2/5] PCI-Express AER implemetation: Add new defines to pci_regs.h
Message-ID: <20060731040045.GC13995@kroah.com>
References: <1154314837.27051.26.camel@ymzhang-perf.sh.intel.com> <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 11:10:39AM +0800, Zhang, Yanmin wrote:
> Although Greg already accepted the second patch into his testing tree,
> I still resend it to keep the patch integrity.

Why?  This is already in 2.6.18-rc3.

Please redo the whole series against 2.6.18-rc3, not 2.6.17, otherwise
it's a pain to forward port...

thanks,

greg k-h
