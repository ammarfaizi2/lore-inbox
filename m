Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268174AbUHYRs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUHYRs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUHYRs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:48:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:9605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268174AbUHYRs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:48:28 -0400
Date: Wed, 25 Aug 2004 10:42:38 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040825174238.GA26714@kroah.com>
References: <20040823225145.GK4694@kroah.com> <20040825173241.54750.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825173241.54750.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 10:32:41AM -0700, Jon Smirl wrote:
> No functional changes from previous version. I fixed the braces and
> diff'd it against 2.6.8.1-mm4. 
> 
> Where does "Signed-off-by:" go in a patch? Jesse and I added a
> copyright  statement.

Please read Documentation/SubmittingPatches for details on this.  It
should just go into the description of what the patch does, that I need
in order to provide a good changelog entry for the patch.

thanks,

greg k-h
