Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267407AbUHZELb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267407AbUHZELb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHZELa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:11:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:11460 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267407AbUHZEKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:10:47 -0400
Date: Wed, 25 Aug 2004 21:10:19 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       sensors@stimpy.netroedge.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
Message-ID: <20040826041019.GA8445@kroah.com>
References: <10934733881970@kroah.com> <1093485846.3054.65.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093485846.3054.65.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 12:04:06PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2004-08-26 at 08:36, Greg KH wrote:
> > ChangeSet 1.1873, 2004/08/25 13:21:22-07:00, khali@linux-fr.org
> > 
> > [PATCH] I2C: keywest class
> > 
> > This is needed for iBook2 owners to be able to use their ADM1030
> > hardware monitoring chip. Successfully tested by one user.
> 
> Vetoed until I get a proper explanation on what that is supposed to do,
> I don't want random stuff mucking around the i2c busses on those machines,
> only specifically written drivers for the chips in there.
> 
> Please, do NOT apply.

Oops, sorry, already in :(

Anyway, sensors people, any further info on this patch?

thanks,

greg k-h
