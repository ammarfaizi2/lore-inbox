Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUBTUBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUBTT6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:58:06 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:36492 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261384AbUBTToV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:44:21 -0500
Date: Fri, 20 Feb 2004 19:41:30 +0000
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI update for 2.6.3
Message-ID: <20040220194130.GA25209@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
References: <20040220190413.GA15063@kroah.com> <10773039771460@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10773039771460@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 11:06:17AM -0800, Greg KH wrote:
 > ChangeSet 1.1557.58.1, 2004/02/18 11:15:56-08:00, mgreer@mvista.com
 > 
 > [PATCH] PCI: Changing 'GALILEO' to 'MARVELL'
 > 
 > I'm working with some Marvell components (formerly Galileo Technologies)
 > and noticed that the entries in include/linux/pci_ids.h have become
 > dated

I just changed this at pciids.sf.net too, so the pci.ids in the kernel
will get updated in the next update.

		Dave
