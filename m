Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVCQXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVCQXLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCQXIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:08:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:6550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261348AbVCQXIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:08:05 -0500
Date: Thu, 17 Mar 2005 14:24:57 -0800
From: Greg KH <greg@kroah.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids.h correction for Intel ICH7M - 2.6.11
Message-ID: <20050317222457.GB6251@kroah.com>
References: <200503041804.43413.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503041804.43413.jason.d.gaston@intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 06:04:43PM -0800, Jason Gaston wrote:
> This patch corrects the ICH7M LPC controller DID in pci_ids.h from
> x27B1 to x27B9. ?This patch was build against 2.6.11.
> If acceptable, please apply.

Applied, thanks.

greg k-h
