Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbTDIRZT (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263641AbTDIRZT (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:25:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41712 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263635AbTDIRZS (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:25:18 -0400
Date: Wed, 9 Apr 2003 10:37:33 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c questions in kernel 2.5.67
Message-ID: <20030409173733.GA14064@kroah.com>
References: <1049902006.1362.6.camel@chevrolet.hybel> <20030409162537.GB1518@kroah.com> <1049909342.1269.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049909342.1269.0.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 07:29:03PM +0200, Stian Jordet wrote:
> ons, 09.04.2003 kl. 18.25 skrev Greg KH:
> > On Wed, Apr 09, 2003 at 05:26:46PM +0200, Stian Jordet wrote:
> > > Hi,
> > > 
> > > I have a Asus CUV266-DLS motherboard, with a as99127f hardware monitor
> > > chip. This is supposed to be supported by the W83781D sensor driver.
> > 
> > Does this motherboard work with this driver on 2.4?  (I'd recommend
> > getting the lm_sensors package from their web site to check this out.)
> 
> Of course I should have checked this better before I sent the first
> mail. I need the i2c-viapro module (in 2.4), which hasn't been ported
> yet.

No problem, want to port that driver and send me a patch?  :)

I sent out a document to the list a week or so ago on the changes
necessary to do this if you're interested.

thanks,

greg k-h
