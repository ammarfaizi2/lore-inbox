Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVBKRHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVBKRHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVBKRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:07:13 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:6478 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262276AbVBKRG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:06:59 -0500
Date: Fri, 11 Feb 2005 09:06:40 -0800
From: Greg KH <gregkh@suse.de>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211170640.GB16074@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211005258.GB26890@kroah.com> <1108085445.12935.0.camel@localhost> <1108104083.32129.0.camel@localhost.localdomain> <1108122427.12911.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108122427.12911.0.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 12:47:07PM +0100, Kasper Sandberg wrote:
> On Thu, 2005-02-10 at 22:41 -0800, Greg KH wrote:
> > On Fri, 2005-02-11 at 02:30 +0100, Kasper Sandberg wrote:
> > > hey greg
> > > 
> > > i remember for some months back, you posted something similar.. is this
> > > a version thats ready for use? if it is! im gonna use it! :D
> > 
> > Yes, this is that version, cleaned up and given a proper build system,
> > and even tested on my machines here :)
> ah cool. and in that case, you probably also have ebuilds for it, if you
> do, please post them somewhere :)

I don't have an ebuild for it yet, but it's on my list to get done.  And
when I do so, it will just show up in the normal gentoo tree.  The main
"issue" with this is I need to create a virtual for the hotplug service
so it doesn't conflict with the existing hotplug package.  Not a big
deal, just not as simple as adding a single ebuild to the tree.

thanks,

greg k-h
