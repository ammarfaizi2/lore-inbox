Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTFECFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTFECFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:05:04 -0400
Received: from granite.he.net ([216.218.226.66]:59654 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264399AbTFECCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:04 -0400
Date: Wed, 4 Jun 2003 19:14:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605021452.GA15711@kroah.com>
References: <20030605013147.GA9804@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605013147.GA9804@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 06:31:47PM -0700, Greg KH wrote:
> 
> p.s. I'll send these as patches in response to this email to lkml for
> those who want to see them.

I don't think everyone really wants to see all 63 different
pci_for_each_dev() removal patches and the huge drivers/hotplug/* move
patch on the mailing lists, so I didn't post them here.  But they are
available, along with all of the patches in this series on your
favoriate kernel.org mirror at:
	kernel.org/pub/linux/kernel/people/gregkh/pci/2.5/*2.5.70*
if people really want to take a look at them.

thanks,

greg k-h
