Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269462AbTGJRDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269450AbTGJRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:00:31 -0400
Received: from storm.he.net ([64.71.150.66]:13733 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269451AbTGJQ75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:59:57 -0400
Date: Thu, 10 Jul 2003 10:14:43 -0700
From: Greg KH <greg@kroah.com>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: CRIS architecture update
Message-ID: <20030710171443.GB12171@kroah.com>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB034C5655@mailse01.axis.se> <3C6BEE8B5E1BAC42905A93F13004E8AB03277A7D@mailse01.axis.se> <20030710171341.GA12171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710171341.GA12171@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 10:13:41AM -0700, Greg KH wrote:
> On Thu, Jul 10, 2003 at 07:24:58AM +0200, Mikael Starvik wrote:
> > Ok, do you have any other suggestion on how to make the driver 
> > compilable for both >= 2.4.20 and < 2.4.20?
> 
> As the driver is _in_ the kernel tree, why does it need to be compilable
> for older kernels?  :)

Speaking of older kernels, any chances for a 2.5 update?  I know the
CRIS USB host controller driver has fallen pretty out of date with the
rest of the USB core, and would hope to see that sync up sometime.

thanks,

greg k-h
