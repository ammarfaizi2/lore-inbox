Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265949AbTFSVEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265952AbTFSVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 17:04:41 -0400
Received: from ida.rowland.org ([192.131.102.52]:4356 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265949AbTFSVEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 17:04:39 -0400
Date: Thu, 19 Jun 2003 17:18:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, <viro@parcelfarce.linux.theplanet.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <Pine.LNX.4.44.0306190932160.955-100000@cherise>
Message-ID: <Pine.LNX.4.44L0.0306191715010.621-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003, Patrick Mochel wrote:

> > > Ok, have you _read_ the documentation on the driver model?  In it,
> > > classes and devices are clearly spelled out as to what the differences
> > > are, and what shows up where.
> > 
> > Yes, of course I've read it.  It's lacking a number of important details.
> 
> Hey, we've tried. I realize it's missing details, and though I know it's 
> important to keep it updated, many other things take precedence. 

Believe me, I understand how hard it is to keep documentation in sync with 
a developing system.

> > Let me ask you this:  Given a device that doesn't fit clearly into any of 
> > the existing classes, how would you decide whether or not to create a new 
> > class for it?
> 
> If it does not fit into the existing classes, then there is probably a new 
> class that needs to be created for it. While you're at it, please update 
> the documentation and set a good example for the rest of us ;)

I'll offer a deal.  When you and Greg have gotten the current set of 
updates into the documentation, let me know and I'll add in explanations 
of all the stuff that has puzzled me and been thrashed out in this thread.

At least I seem to be making progress.  Thanks for the help.

Alan Stern

