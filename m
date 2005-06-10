Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVFJEGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVFJEGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVFJEGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:06:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:22660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262464AbVFJEGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:06:30 -0400
Date: Thu, 9 Jun 2005 21:06:11 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: mj@ucw.cz, pciids-devel@lists.sourceforge.net,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PCI IDs for NVida nForce
Message-ID: <20050610040611.GA14766@kroah.com>
References: <20050609233312.GA3089@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609233312.GA3089@hockin.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 04:33:12PM -0700, Tim Hockin wrote:
> Info from a CK804 (nForce4, nForce Pro, etc) board:
> 
> Signed-off-by: Tim Hockin <thockin@hockin.org>
> 
> 
> --- old/drivers/pci/pci.ids	2005-06-09 16:29:08.000000000 -0700
> +++ new/drivers/pci/pci.ids	2005-05-11 19:37:07.000000000 -0700

What kernel version is this against?

If it's 2.6, you do know this file is going away next month, right?

thanks,

greg k-h
