Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUKEXWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUKEXWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUKEXUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:20:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:31953 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261260AbUKEXRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:17:13 -0500
Date: Fri, 5 Nov 2004 15:06:27 -0800
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.6] cyclades.c: replace pci_find_device
Message-ID: <20041105230627.GE31080@kroah.com>
References: <267570000.1098383749@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267570000.1098383749@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 11:35:49AM -0700, Hanna Linder wrote:
> 
> As pci_find_device is going away I've replaced it with pci_get_device.
> If someone with this hardware could test it I would appreciate it.
> 
> Thanks.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>


Applied, thanks.

greg k-h

