Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422630AbWHEGlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWHEGlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 02:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbWHEGlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 02:41:42 -0400
Received: from ns2.suse.de ([195.135.220.15]:36495 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161534AbWHEGll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 02:41:41 -0400
Date: Fri, 4 Aug 2006 23:41:23 -0700
From: Greg KH <greg@kroah.com>
To: Helmut <bgrpt@toplitzer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci=assign-busses output and problems
Message-ID: <20060805064123.GB25389@kroah.com>
References: <200608031204.56842.bgrpt@toplitzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608031204.56842.bgrpt@toplitzer.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 12:04:56PM +0200, Helmut wrote:
> 
> dmesg output told me to send this to this list.
> However, rebooting after using pci=assign-busses distorts my
> boot-screen after 1 sec. and is scrambled until xserver starts.
> Xserver is working ok, text-console keeps being scrambled.
> 
> Attaching pci-assign-busses.txt with output and a output of dmesg before using
> this option.

Which device is being hidden here?  And if everything is working
properly, I wouldn't worry much about it :)

thanks,

greg k-h
