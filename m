Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUCDCiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUCDCiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:38:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30930 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261410AbUCDCiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:38:11 -0500
Message-ID: <40469683.3000609@pobox.com>
Date: Wed, 03 Mar 2004 21:37:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com>
In-Reply-To: <20040304023524.GA19453@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Hi Dave & Jeff,
> 
> 	The attached .bz2 file is a patch for 2.6.3 adding the
> Intersil Prism54 wireless driver. Sorry for the attachement, the file
> is rather big, if you want inline+plaintext, I'll send that personal
> to you.
> 	I've been using this driver with great success on 2.6.3 and
> 2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
> 802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
> chipset.
> 	I would like this driver to go into 2.6.X. However, I
> understand that it's lot's of code to review.


I would like it to go into 2.6 too :)  I'm glad somebody submitted it.

I'll review it this weekend... and hopefully some other netdev denizens 
will review as well and post their comments.

	Jeff



