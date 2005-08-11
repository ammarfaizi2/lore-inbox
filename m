Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVHKRlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVHKRlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVHKRlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:41:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:5844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932301AbVHKRlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:41:22 -0400
Date: Thu, 11 Aug 2005 10:40:55 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: S3 wakeup broken by one commit (was Re: bisect gives strange answer)
Message-ID: <20050811174055.GB14955@kroah.com>
References: <20050811183008.A18655@jurassic.park.msu.ru> <E1E3E98-0007D2-00@skye.ra.phy.cam.ac.uk> <20050811185759.A18818@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811185759.A18818@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 06:57:59PM +0400, Ivan Kokshaysky wrote:
> On Thu, Aug 11, 2005 at 03:35:02PM +0100, Sanjoy Mahajan wrote:
> > Right, it is fixed.
> 
> Maybe Greg didn't know that - if so, I don't think this
> test is necessary.

Yes, I didn't realize this was already fixed.  Very sorry about that, no
tests are needed at all.

thanks,

greg k-h
