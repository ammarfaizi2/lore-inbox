Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUC0Aa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUC0Aa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:30:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:15243 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261563AbUC0Aay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:30:54 -0500
Date: Fri, 26 Mar 2004 16:29:35 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-ID: <20040327002935.GB13097@kroah.com>
References: <20040323052305.GA2287@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323052305.GA2287@havoc.gtf.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:23:05AM -0500, Jeff Garzik wrote:
> 
> Been meaning to do this for ages...
> 
> Another one for the janitors.
> 
> Please do a
> 
> 	bk pull bk://kernel.bkbits.net/jgarzik/pci-dma-mask-2.6
> 
> This will update the following files:

Nice, I've pulled this to my pci tree and will forward it on to Linus in
the next round of pci patches after 2.6.5 is out.

thanks,

greg k-h
