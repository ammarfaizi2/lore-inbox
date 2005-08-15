Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVHOQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVHOQZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVHOQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:25:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:14776 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964818AbVHOQZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:25:02 -0400
Date: Mon, 15 Aug 2005 09:24:37 -0700
From: Greg KH <greg@kroah.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Message-ID: <20050815162437.GA10114@kroah.com>
References: <20050815102925.GA843@localhost.localdomain> <20050815110836.GA16201@mipter.zuzino.mipt.ru> <20050815112122.GB6451@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815112122.GB6451@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 01:21:22PM +0200, Stephane Wirtel wrote:
> Le Monday 15 August 2005 a 15:08, Alexey Dobriyan ecrivait: 
> > On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> > > With a laptop hard disk adaptop to usb, I do a modprobe with the
> > > usb-storage module. If I disconnect my hard disk, I get an oops.
> > 
> > > nvidia 3711688 14 - Live 0xe10f1000
> > 
> > > EIP:    0060:[<c019710b>]    Tainted: P      VLI
> > 
> > Is it reproducable without nvidia module loaded?
> Yes :( 

Can you do so with 2.6.13-rc6 and without the nvidia module?  If so,
please let us know.

thanks,

greg k-h
