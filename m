Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161329AbWI2SNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWI2SNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWI2SNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:13:07 -0400
Received: from mail.suse.de ([195.135.220.2]:23459 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161329AbWI2SNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:13:05 -0400
Date: Fri, 29 Sep 2006 11:12:40 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [patch] change pci hotplug subsystem maintainer to Kristen
Message-ID: <20060929181240.GA14632@kroah.com>
References: <20060929103027.84bc7aab.kristen.c.accardi@intel.com> <20060929173703.GN5017@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929173703.GN5017@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 11:37:03AM -0600, Matthew Wilcox wrote:
> On Fri, Sep 29, 2006 at 10:30:27AM -0700, Kristen Carlson Accardi wrote:
> > Hi Greg,
> > Here's a patch adding me to the maintainers file for the pci 
> > hotplug subsystem, as we discussed.
> 
> Where does this leave the s/hotplug_slot/pci_slot/ patch?  I noticed it
> didn't go into the last push to Linus.

Crap, forgot that...

Gee, me forgetting a gratitous "break the api" patch seems a bit odd :)

I'll do that and submit this changeover MAINTAINERS patch at the same
time, so Kristen doesn't have to worry about it.

thanks,

greg k-h
