Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUCDCtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCDCtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:49:36 -0500
Received: from palrel12.hp.com ([156.153.255.237]:56962 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261423AbUCDCte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:49:34 -0500
Date: Wed, 3 Mar 2004 18:49:32 -0800
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040304024932.GA19781@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040304023524.GA19453@bougret.hpl.hp.com> <40469683.3000609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40469683.3000609@pobox.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 09:37:55PM -0500, Jeff Garzik wrote:
> Jean Tourrilhes wrote:
> >	Hi Dave & Jeff,
> >
> >	The attached .bz2 file is a patch for 2.6.3 adding the
> >Intersil Prism54 wireless driver. Sorry for the attachement, the file
> >is rather big, if you want inline+plaintext, I'll send that personal
> >to you.
> >	I've been using this driver with great success on 2.6.3 and
> >2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
> >802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
> >chipset.
> >	I would like this driver to go into 2.6.X. However, I
> >understand that it's lot's of code to review.
> 
> 
> I would like it to go into 2.6 too :)  I'm glad somebody submitted it.
> 
> I'll review it this weekend... and hopefully some other netdev denizens 
> will review as well and post their comments.
> 
> 	Jeff

	By the way, I should note that during my test I had
difficulties to associate with Aironet cards, but it looked like it
was a firmware related issue (firmware timing out). The rest work fine
(managed to Lucent, Ad-Hoc to another Prism54, scanning,
WE). Actually, this is the driver I used to develop ifrename.
	Have fun...

	Jean

