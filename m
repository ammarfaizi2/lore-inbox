Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932254AbWFDVGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWFDVGi (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWFDVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:06:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:5510 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932254AbWFDVGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:06:38 -0400
Date: Sun, 4 Jun 2006 14:01:16 -0700
From: Greg KH <greg@kroah.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG](-mm)pci_disable_device function clear bars_enabled element
Message-ID: <20060604210116.GA25027@kroah.com>
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <20060602055642.GC1501@colo.lackof.org> <447FE943.3010702@jp.fujitsu.com> <20060603232133.GA7109@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603232133.GA7109@colo.lackof.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2006 at 05:21:33PM -0600, Grant Grundler wrote:
> On Fri, Jun 02, 2006 at 04:31:15PM +0900, Kenji Kaneshige wrote:
> > I think that list would be very useful. But as you said, there are
> > other steps remaining than ones I came up with at once. I can't
> > deal with the steps of all of them...
> 
> Ok. I'm motivated to clean up/rewrite that file...
> Greg, you want that peice meal or all in one patch?

All in one is probably easier, unless you think you can break it up into
logicial pieces.

thanks,

greg k-h
