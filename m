Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTGaBOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272365AbTGaBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 21:14:53 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:57098 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272287AbTGaBOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 21:14:52 -0400
Date: Thu, 31 Jul 2003 03:14:50 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030731011450.GA2772@win.tue.nl>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730231753.GB5491@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:17:53PM -0700, Greg KH wrote:
> On Tue, Jul 29, 2003 at 05:07:05PM -0500, Grant Miner wrote:
> > I have a Microtech CompactFlash ZiO! USB
> > P:  Vendor=04e6 ProdID=1010 Rev= 0.05
> > S:  Manufacturer=SHUTTLE
> > S:  Product=SCM Micro USBAT-02
> > 
> > but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> > worked in 2.4 either.)  config is attached.  Any ideas?
> 
> Linux doesn't currently support this device, sorry.

Hmm. I think I recall seeing people happily using that.
Do I misremember?

Google gives
  http://www.scm-pc-card.de/service/linux/zio-cf.html
and
  http://usbat2.sourceforge.net/

Andries

