Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUBTT5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbUBTTyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:54:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:52620 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261401AbUBTTxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:53:52 -0500
Date: Fri, 20 Feb 2004 11:53:48 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI update for 2.6.3
Message-ID: <20040220195348.GA15691@kroah.com>
References: <20040220190413.GA15063@kroah.com> <10773039771460@kroah.com> <20040220194130.GA25209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220194130.GA25209@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 07:41:30PM +0000, Dave Jones wrote:
> On Fri, Feb 20, 2004 at 11:06:17AM -0800, Greg KH wrote:
>  > ChangeSet 1.1557.58.1, 2004/02/18 11:15:56-08:00, mgreer@mvista.com
>  > 
>  > [PATCH] PCI: Changing 'GALILEO' to 'MARVELL'
>  > 
>  > I'm working with some Marvell components (formerly Galileo Technologies)
>  > and noticed that the entries in include/linux/pci_ids.h have become
>  > dated
> 
> I just changed this at pciids.sf.net too, so the pci.ids in the kernel
> will get updated in the next update.

Nice, thanks for doing this.

greg k-h
