Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVAFVy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVAFVy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVAFVyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:54:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27856 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263036AbVAFVvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:51:16 -0500
Date: Thu, 6 Jan 2005 13:41:32 -0800
From: Greg KH <greg@kroah.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C support for Intel ICH7 - 2.6.10
Message-ID: <20050106214132.GA26109@kroah.com>
References: <200412301024.39384.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412301024.39384.jason.d.gaston@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 10:24:39AM -0800, Jason Gaston wrote:
> This patch adds the Intel ICH7 DID to the i2c-i801.c driver and adds
> an entry to Kconfig for I2C(SMBus) support. ?
> Note: This patch relies on the already submitted and accepted PATA
> patch to pci_ids.h containing all ICH7 DID's.

Did I already apply this patch?

> If acceptable, please apply. 

I need a "Signed-off-by:" line to be able to apply it.  See
Documentation/SubmittingPatches for more info.

Care to resend it?

thanks,

greg k-h
