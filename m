Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUHEWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUHEWmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268011AbUHEWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:42:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:31978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268000AbUHEWmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:42:08 -0400
Date: Thu, 5 Aug 2004 15:41:29 -0700
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document pci_disable_device()
Message-ID: <20040805224128.GB18523@kroah.com>
References: <200408031426.29228.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031426.29228.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:26:29PM -0600, Bjorn Helgaas wrote:
> Add documentation for pci_disable_device().  We don't actually
> deallocate IRQ resources in pci_disable_device() yet, but I suspect
> we'll need to do so soon.

Applied, thanks,

greg k-h
