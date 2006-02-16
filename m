Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWBPSDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWBPSDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWBPSDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:03:18 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:45468
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030387AbWBPSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:03:18 -0500
Date: Thu, 16 Feb 2006 10:03:11 -0800
From: Greg KH <greg@kroah.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060216180311.GB13308@kroah.com>
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner> <20060214223001.GB357@kroah.com> <20060215004320.GB21742@merlin.emma.line.org> <20060215052051.GA22240@kroah.com> <20060216120129.GA8878@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216120129.GA8878@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 01:01:29PM +0100, Matthias Andree wrote:
> On Tue, 14 Feb 2006, Greg KH wrote:
> 
> > > And that is the key problem. magazine here, conference there, talk
> > > (perhaps only slides available) somewhere else -- a manual that was in
> > > /usr/src/linux/Documentation might make a real difference. Even a
> > > commented link list in Documentation/* might be a good starting point.
> > > 
> > > Patrick Mochel added some bits three years ago, but they were internals
> > > and thus a bit less interesting.
> > 
> > What would be "interesting"?  The sysfs and driver model chapter of the
> > Linux Device Driver book from Oreilly, third edition?  Or something
> > oriented toward users of sysfs, not developers using it?
> 
> Integrating documentation with the kernel.

What kind of documentation?  user oriented documentation like how to
find specific stuff in sysfs?  Or developer oriented documentation, like
we have there now.

> Documentation/* is constantly out of date and incomplete, and
> sometimes has non-intuitive names.

It's not always out of date.  And patches are always gladly accepted.

Also, what non-intuitive names are you referring to?

thanks,

greg k-h
