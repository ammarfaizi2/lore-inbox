Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269039AbUI2VOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269039AbUI2VOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUI2VOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:14:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:31373 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269043AbUI2VNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:13:16 -0400
Date: Wed, 29 Sep 2004 10:48:29 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, johnrose@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] PPC64: Add pcibios_remove_root_bus
Message-ID: <20040929174828.GA12906@kroah.com>
References: <16730.17836.508342.113165@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16730.17836.508342.113165@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:18:36PM +1000, Paul Mackerras wrote:
> From: John Rose <johnrose@austin.ibm.com>
> 
> The following patch creates pcibios_remove_root_bus(), which performs
> the ppc64-specific actions for removal of PCI Host Bridges.  This call
> is invoked by the RPA DLPAR driver upon PHB removal.

Applied, thanks.

greg k-h
