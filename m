Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVANSma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVANSma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVANSma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:42:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:24729 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261325AbVANSmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:42:12 -0500
Date: Fri, 14 Jan 2005 10:42:00 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C-MPC: Convert to platform_device driver
Message-ID: <20050114184159.GB30093@kroah.com>
References: <Pine.LNX.4.61.0501132130580.27720@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501132130580.27720@blarg.somerset.sps.mot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 09:35:32PM -0600, Kumar Gala wrote:
> Converted the driver to work as either a OCP or platform_device driver.  
> The intent in the future (once we convert all PPC sub-archs from OCP to 
> platform_device) is to remove the OCP code.

Applied, thanks.

greg k-h
