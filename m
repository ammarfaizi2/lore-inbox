Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbUKJRgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbUKJRgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUKJRgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:36:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:32993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262021AbUKJRgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:36:13 -0500
Date: Wed, 10 Nov 2004 09:35:48 -0800
From: Greg KH <greg@kroah.com>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       Michael Chan <mchan@broadcom.com>,
       "Goswami, Pranjal" <pranjal.goswami@intel.com>,
       Andrew Morton <akpm@zip.com.au>, Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041110173547.GB11688@kroah.com>
References: <FEB6C4E97F6CAF41978FB2059D545418B6BB6E@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEB6C4E97F6CAF41978FB2059D545418B6BB6E@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 10:56:45PM +0530, Durairaj, Sundarapandian wrote:
> Here I have attached pci mmconfig fix for 2.6.9 kernel. 

Your patch is line wrapped, and mime encoded.  Two things that prevent
it from being applied :(

Oh, and you forgot a "Signed-off-by:" line.

Care to redo it?

thanks,

greg k-h
