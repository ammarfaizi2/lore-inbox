Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbTFFFR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265310AbTFFFR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:17:27 -0400
Received: from granite.he.net ([216.218.226.66]:56338 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265309AbTFFFRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:17:25 -0400
Date: Thu, 5 Jun 2003 22:27:16 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: move pci_present() into drivers/pci/search.c
Message-ID: <20030606052716.GB9328@kroah.com>
References: <200306052322.h55NMmEg019146@hera.kernel.org> <3EE01DA0.5080808@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE01DA0.5080808@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 12:50:40AM -0400, Jeff Garzik wrote:
> 
> IMO pci_present should go before 2.6.0...  it's lived long enough.

Good point, I agree.  I'll see about making these changes after I finish
some of these other PCI changes.

thanks,

greg k-h
