Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWBJEY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWBJEY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWBJEY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:24:27 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:34211
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751068AbWBJEY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:24:26 -0500
Date: Thu, 9 Feb 2006 20:24:19 -0800
From: Greg KH <greg@kroah.com>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel hackers.
Message-ID: <20060210042419.GA27457@kroah.com>
References: <20060210000101.2f028801.lista1@telia.com> <20060209233233.GB23971@kroah.com> <20060210035051.55dbb74a.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210035051.55dbb74a.lista1@telia.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 03:50:51AM +0100, Voluspa wrote:
> On Thu, 9 Feb 2006 15:32:33 -0800 Greg KH wrote:
> > On Fri, Feb 10, 2006 at 12:01:01AM +0100, Voluspa wrote:
> > > 
> > > Booted 2.6.16-rc2 on my AMD x86_64 notebook and saw something new in the
> > > log (different from 2.6.15):
> > 
> > So, 2.6.16-rc2 works just fine, with out your reversal of that one
> > patch?
> 
> Eh, I bundled two issues in my rant. 1) nsxfeval, which the ACPI guys
> have confirmed is pure noise and can be forgotten. 2) "PCI: Failed to
> allocate mem resource" which has been there since the commit I pointed
> to, and never has effected the machine negatively (as far as I can tell).
> So yes, 2.6.16-rc2 seems fine, and I don't patch it for that PCI thing.
> It's just that the message is present and will worry people 'forever'
> if nothing is done.

As long as everything is working properly, you can happily ignore the
issue and blame your bios vendor for making such a stupid mistake :)

> Yeah, I know, sorry if I jabbed too hard. I was caught up in a sadness for
> anyone who's mail is ignored. There is a form of humiliation when that
> happens on a high profile list like lkml or other kernel related lists.
> A mirror of the defeat can be found on a small server in Korpilombolo for
> the next two decades at least.

I know it's tough when things like this are ignored, and no, you didn't
jab to hard at all.  We all need to be reminded when we forget things
like this, myself especially at times :)

> But I must say that during the years that I've read lkml, it _feels_ as if
> the reply-rate has improved significantly. The list is not as terrifying as
> it used to be.

Glad to hear it, we are trying here...

thanks,

greg k-h
