Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVALAqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVALAqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVALAoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:44:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33495 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262983AbVALAh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:37:56 -0500
Date: Tue, 11 Jan 2005 16:37:16 -0800
From: Greg KH <greg@kroah.com>
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids.h correction for Intel ICH7 - 2.6.10-bk13
Message-ID: <20050112003716.GB20607@kroah.com>
References: <200501100636.50064.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501100636.50064.jason.d.gaston@intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 06:36:49AM -0800, Jason Gaston wrote:
> This patch corrects the ICH7 LPC controller DID in pci_ids.h from x27B0 to x27B8.  This patch was build against 2.6.10-bk13.
> If acceptable, please apply.
> 
> Thanks,
> 
> Jason Gaston
> 
> Signed-off-by: ?Jason Gaston <Jason.d.gaston@intel.com>

Applied, thanks.

greg k-h
