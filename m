Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWBOFVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWBOFVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422960AbWBOFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:21:04 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:1674 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750907AbWBOFVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:21:02 -0500
Date: Tue, 14 Feb 2006 21:20:52 -0800
From: Greg KH <greg@kroah.com>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215052051.GA22240@kroah.com>
References: <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner> <20060214223001.GB357@kroah.com> <20060215004320.GB21742@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215004320.GB21742@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:43:20AM +0100, Matthias Andree wrote:
> > > Please send me the other documentation (e.g. man pages) on the /sys
> > > device
> > 
> > What "/sys device"?  sysfs is a file system, and there have been many
> > magazine articles, and conference papers written, and talks given on the
> > topic.
> 
> And that is the key problem. magazine here, conference there, talk
> (perhaps only slides available) somewhere else -- a manual that was in
> /usr/src/linux/Documentation might make a real difference. Even a
> commented link list in Documentation/* might be a good starting point.
> 
> Patrick Mochel added some bits three years ago, but they were internals
> and thus a bit less interesting.

What would be "interesting"?  The sysfs and driver model chapter of the
Linux Device Driver book from Oreilly, third edition?  Or something
oriented toward users of sysfs, not developers using it?

thanks,

greg k-h
