Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269569AbTGJVOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269576AbTGJVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:14:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269569AbTGJVOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:14:50 -0400
Message-ID: <3F0DDAA9.5010404@pobox.com>
Date: Thu, 10 Jul 2003 17:29:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Martin Diehl <lists@mdiehl.de>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: IrDA patches for 2.5.X
References: <20030709234819.GA12747@bougret.hpl.hp.com>
In-Reply-To: <20030709234819.GA12747@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Hi Jeff,
> 
> 	Here are a bunch of patches to push to 2.5.X alongside the
> patches from Martin. As you can see, many trivial fixes to the core,
> and some more driver work. I'm quite pleased that VIA contributed a
> driver for their hardware.

Yeah, I give Via a huge kudos for stepping up their open source code.  I 
worked with Joseph Chan (who submitted the IrDA driver) on the Via RNG 
support, and Via has been releasing other drivers as well (particularly 
a _lot_ of XFree code).


> 	Patches tested on 2.5.74, been a few weeks on my web page
> without anybody complaining.

All patches except for the Via driver applied.

	Jeff



