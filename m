Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSIXAEF>; Mon, 23 Sep 2002 20:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSIXAEF>; Mon, 23 Sep 2002 20:04:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:36612 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261505AbSIXAEE>;
	Mon, 23 Sep 2002 20:04:04 -0400
Date: Mon, 23 Sep 2002 17:08:20 -0700
From: Greg KH <greg@kroah.com>
To: "Rhoads, Rob" <rob.rhoads@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Hardened Device Drivers Project
Message-ID: <20020924000820.GB20686@kroah.com>
References: <D9223EB959A5D511A98F00508B68C20C0A5389BB@orsmsx108.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0A5389BB@orsmsx108.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 03:38:32PM -0700, Rhoads, Rob wrote:
> 
> Rather than bog down this mailing list with exchanges, 
> I would like to move this discussion to the hardened 
> driver mailing list.  Please don't feel like I'm 
> ignoring your feedback--just moving the forum.

No, please don't move this off to another mailing list.  This is where
the majority of all kernel programmers are, don't try to make us move to
yet-another-mailing-list just to discuss your project.  If you want our
contributions, and want our input, use this list.

If you stay on smaller mailing lists, like cg-discuss and
hardened-drivers, you do not reach the widest group of people, which is
what you will have to do if you want to have a chance for your
contributions to become part of the main kernel.

> An underlying theme tends to revolve around the binding
> of the concepts of 'hardening' and RAS features being 
> added to drivers.  We will be looking into splitting 
> these two different approaches out from this singular 
> document and into their appropriate locations.

Where would these locations be?

> If you are interested (even if you aren't) please go 
> to http://lists.sourceforge.net/lists/listinfo/hardeneddrivers-discuss 
> and subscribe to the mailing list.

Sorry, but major kernel driver discussions should occur on lkml.

thanks,

greg k-h
