Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVAQWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVAQWaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVAQWY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:24:57 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:36790 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262945AbVAQWMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:12:19 -0500
Date: Mon, 17 Jan 2005 14:12:14 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] I2C fixes for 2.6.11-rc1
Message-ID: <20050117221214.GA29158@kroah.com>
References: <20050117214543.GB28400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117214543.GB28400@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 01:45:43PM -0800, Greg KH wrote:
> Hi,
> 
> Here are some i2c driver fixes and updates for 2.6.11-rc1.  There is a
> new chip and a new bus driver, as well as a bunch of minor fixes.  All
> of these patches have been in the past few -mm releases.

Oops, no new chip and bus drivers here, just some bigger updates to a
chip and a bus driver.  Sorry for misreading the diffstat.

But the patches are all still good :)

thanks,

greg k-h

