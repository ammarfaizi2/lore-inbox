Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbUK2TfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbUK2TfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUK2TeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:34:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1744 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261614AbUK2TKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:10:46 -0500
Date: Mon, 29 Nov 2004 11:08:00 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Stelian Pop <stelian@popies.net>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041129190800.GE15452@kroah.com>
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net> <419FD192.1040604@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419FD192.1040604@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 03:21:54PM -0800, Randy.Dunlap wrote:
> 
> Until 'suggests' is available, does this help any?
> It's tough getting people to read Help messages though.
> 
> 
> 
> Add comment/NOTE that USB_STORAGE probably needs BLK_DEV_SD also.
> Add a few device types to help text and reformat it.

Applied, thanks.

greg k-h

