Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUIVUka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUIVUka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUIVUka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:40:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:8417 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267522AbUIVUk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:40:29 -0400
Date: Wed, 22 Sep 2004 13:38:56 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc1-mm5 acpi.c] Changed pci_find_device to pci_get_device
Message-ID: <20040922203856.GA13064@kroah.com>
References: <8240000.1095371651@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8240000.1095371651@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 02:54:11PM -0700, Hanna Linder wrote:
> 
> Another simple patch to complete the /i386 conversion to pci_get_device.
> I was able to compile and boot this patch to verify it didn't break anything
> (on my T22).
> 
> Thanks.
> 
> Hanna Linder
> IBM Linux Technology Center
> 
> Signed-off-by: Hanna Linder <hannal@us.ibm.com>

Applied, thanks.

greg k-h
