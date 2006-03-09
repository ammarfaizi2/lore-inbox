Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWCIFtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWCIFtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWCIFtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:49:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:4490 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932685AbWCIFtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:49:14 -0500
Date: Wed, 8 Mar 2006 21:34:30 -0800
From: Greg KH <gregkh@suse.de>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for 2.6.16-rc5
Message-ID: <20060309053430.GA8528@suse.de>
References: <20060306223545.GA20885@kroah.com> <440FA87C.7000504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FA87C.7000504@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:01:00PM +0900, Kenji Kaneshige wrote:
> Could you please add "PCI legacy I/O port free driver"
> (http://www.ussg.iu.edu/hypermail/linux/kernel/0603.0/1923.html)
> to Future stuff? I hope the set of patches would be tested on -mm tree
> for a while.

I will, they are in my TODO queue, don't worry, I haven't forgotten them
:)

thanks,

greg k-h
