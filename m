Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWCHWuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWCHWuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCHWuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:50:54 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:26496
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932440AbWCHWuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:50:54 -0500
Date: Wed, 8 Mar 2006 14:50:29 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060308225029.GA26117@suse.de>
References: <20060306223545.GA20885@kroah.com> <20060308222652.GR4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308222652.GR4006@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:26:52PM +0100, Adrian Bunk wrote:
> On Mon, Mar 06, 2006 at 02:35:45PM -0800, Greg KH wrote:
> 
> > Here's a summary of the current state of the Linux PCI and PCI Hotplug
> > subsystems as of 2.6.16-rc5
> > 
> > If the information in here is incorrect, or anyone knows of any
> > outstanding issues not listed here, please let me know.
> >...
> > Was this summary useful for people?  Anything that I should add to it?
> 
> It is useful, but one thing seems to be missing:
> Which patches do you intend to forward for 2.6.16 (if any)?

None, as I am expecting 2.6.16 to be out any day now.

> (pci-pci-quirk-for-asus-a8v-and-a8v-deluxe-motherboards.patch seems to
>  be a candidate.)

Yes, if people really want it in I could send it, but I was just looking
for "bugfixes only" at this late stage of the game.

thanks,

thanks,

greg k-h
