Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbVIAR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVIAR7j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVIAR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:59:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030268AbVIAR7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:59:38 -0400
Date: Thu, 1 Sep 2005 10:59:50 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Steve Kieu <haiquy@yahoo.com>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Daniel Drake <dsd@gentoo.org>, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Message-ID: <20050901105950.6766e299@dxpl.pdx.osdl.net>
In-Reply-To: <20050831000948.40799.qmail@web53607.mail.yahoo.com>
References: <20050830152908.1dc24339@dxpl.pdx.osdl.net>
	<20050831000948.40799.qmail@web53607.mail.yahoo.com>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005 10:09:48 +1000 (EST)
Steve Kieu <haiquy@yahoo.com> wrote:

> 
> --- Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > On Wed, 31 Aug 2005 07:49:37 +1000 (EST)
> 
> > > 
> > > install-8_23.tar.bz2
> > 
> > Just look for references to CHIP_REV_YU_LITE_A3 in
> > the driver
> > 	sk98lin/skgeinit.c and sk98lin/skxmac2.c
> > The comparison should always be:
> 
> Have a look but no clue to patch it, there are one
> instance of comparing

I don't fix the out of tree vendor driver. sorry.
