Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWGaEj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWGaEj5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWGaEj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:39:57 -0400
Received: from mga06.intel.com ([134.134.136.21]:46484 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751469AbWGaEj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:39:56 -0400
X-IronPort-AV: i="4.07,196,1151910000"; 
   d="scan'208"; a="98881285:sNHT31507056"
Subject: Re: [PATCH 2/5] PCI-Express AER implemetation: Add new defines to
	pci_regs.h
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Tom Long Nguyen <tom.l.nguyen@intel.com>
In-Reply-To: <20060731040045.GC13995@kroah.com>
References: <1154314837.27051.26.camel@ymzhang-perf.sh.intel.com>
	 <1154315439.27051.29.camel@ymzhang-perf.sh.intel.com>
	 <20060731040045.GC13995@kroah.com>
Content-Type: text/plain
Message-Id: <1154320698.27051.48.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 31 Jul 2006 12:38:18 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 12:00, Greg KH wrote:
> On Mon, Jul 31, 2006 at 11:10:39AM +0800, Zhang, Yanmin wrote:
> > Although Greg already accepted the second patch into his testing tree,
> > I still resend it to keep the patch integrity.
> 
> Why?  This is already in 2.6.18-rc3.
I checked 2.6.18-rc3 and it doesn't include the patch of pci_regs.h.

> 
> Please redo the whole series against 2.6.18-rc3, not 2.6.17, otherwise
> it's a pain to forward port...
The patches could be applied to 2.6.18-rc3 cleanly. There is no any
confliction and I tested them under 2.6.18-rc3.

Is it necessary to rebase to 2.6.18-rc3?

Thanks,
Yanmin
