Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWI2SPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWI2SPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWI2SPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:15:13 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:54434 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422642AbWI2SPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:15:12 -0400
Date: Fri, 29 Sep 2006 12:15:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [patch] change pci hotplug subsystem maintainer to Kristen
Message-ID: <20060929181511.GP5017@parisc-linux.org>
References: <20060929103027.84bc7aab.kristen.c.accardi@intel.com> <20060929173703.GN5017@parisc-linux.org> <20060929181240.GA14632@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929181240.GA14632@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 11:12:40AM -0700, Greg KH wrote:
> On Fri, Sep 29, 2006 at 11:37:03AM -0600, Matthew Wilcox wrote:
> > On Fri, Sep 29, 2006 at 10:30:27AM -0700, Kristen Carlson Accardi wrote:
> > > Hi Greg,
> > > Here's a patch adding me to the maintainers file for the pci 
> > > hotplug subsystem, as we discussed.
> > 
> > Where does this leave the s/hotplug_slot/pci_slot/ patch?  I noticed it
> > didn't go into the last push to Linus.
> 
> Crap, forgot that...
> 
> Gee, me forgetting a gratitous "break the api" patch seems a bit odd :)

If you wanted to preserve the API for a while, we could put in a few
#defines ...

> I'll do that and submit this changeover MAINTAINERS patch at the same
> time, so Kristen doesn't have to worry about it.

Thanks!
