Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTFWWF0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTFWWFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:05:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50676 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265387AbTFWWFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:05:19 -0400
Date: Mon, 23 Jun 2003 15:12:32 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_raw_ops devfn
Message-ID: <20030623221232.GA11244@kroah.com>
References: <20030623194021.GC25982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623194021.GC25982@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 08:40:21PM +0100, Matthew Wilcox wrote:
> 
> Combine the dev and func arguments to pci_raw_ops into devfn which is
> more natural all around.

Applied, thanks.

greg k-h
