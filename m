Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVCaTHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVCaTHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVCaTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:07:12 -0500
Received: from fmr21.intel.com ([143.183.121.13]:4252 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261623AbVCaTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:07:06 -0500
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
From: Len Brown <len.brown@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: "Shah, Rajesh" <rajesh.shah@intel.com>,
       "linux-pci@atrey.karlin.mff.cuni.cz" 
	<linux-pci@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, Tony Luck <tony.luck@intel.com>,
       "Sy, Dely L" <dely.l.sy@intel.com>
In-Reply-To: <20050321182745.GA5201@suse.de>
References: <20050318133856.A878@unix-os.sc.intel.com>
	 <20050319051331.GC21485@suse.de>
	 <20050321100457.A4477@unix-os.sc.intel.com> <20050321182745.GA5201@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1112295995.2110.38.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2005 14:06:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 13:27, Greg KH wrote:
> On Mon, Mar 21, 2005 at 10:04:57AM -0800, Rajesh Shah wrote:
> > >     - Are you wanting the acpi specific patches to go into the
> tree
> > >       through the acpi developers?  How about the ia64 specific
> > >       patches?
> >
> > I honestly don't know what the best approach is here - what do you
> > recommend? I did receive an email from Andrew indicating he wants
> > to pick these up for the next mm. Perhaps the best thing is to
> > let Andrew include the whole series after I've addressed all
> > feedback and you, Tony, Len etc. all agree these are OK to go in.
> 
> That sounds like a fine plan to me.

Me too.

And I don't see any issues with the ACPI specific changes.

cheers,
-Len


