Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTHSVEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbTHSVEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:04:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:33177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261464AbTHSVCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:02:25 -0400
Date: Tue, 19 Aug 2003 14:02:24 -0700
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't read fan-speeds from i2c
Message-ID: <20030819210223.GB6170@kroah.com>
References: <1061324213.708.6.camel@chevrolet.hybel> <20030819205356.GA5968@kroah.com> <1061326633.611.8.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061326633.611.8.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 10:57:13PM +0200, Stian Jordet wrote:
> tir, 19.08.2003 kl. 22.53 skrev Greg KH:
> > On Tue, Aug 19, 2003 at 10:16:53PM +0200, Stian Jordet wrote:
> > > Hi,
> > > 
> > > I have a Asus CUV266-DLS, which uses the as99127f chipset. Everything
> > > seems to work as it is supposed to, except for fan-speeds. They say 0.
> > > Is that supposed behaviour since the as99127f doesn't have any
> > > datasheets, or am I doing something wrong?
> > 
> > What kernel version are you using?
> 
> Latest bk-snapshot...

Does 2.4 work just fine for this chip and driver and 2.6 does not?  If
2.4 also doesn't work, I would suggest bringing this up on the sensors
mailing list.

thanks,

greg k-h
