Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUCDFQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUCDFQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:16:41 -0500
Received: from havoc.gtf.org ([216.162.42.101]:5264 "EHLO gtf.org")
	by vger.kernel.org with ESMTP id S261453AbUCDFQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:16:40 -0500
Date: Thu, 4 Mar 2004 00:16:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 2.6] Patch to hook up PPP to simple class sysfs support
Message-ID: <20040304051638.GA30560@havoc.gtf.org>
References: <200403032328.i23NSwlv009796@orion.dwf.com> <22370000.1078362205@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22370000.1078362205@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 05:03:26PM -0800, Hanna Linder wrote:
> 
> Here is a small patch to add PPP support to /sys/class.
> 
> Please consider for inclusion.
> 
> Thanks.
> 
> Hanna
> ----
> 
> diff -Nrup -Xdontdiff linux-2.6.3/drivers/net/ppp_generic.c 
> linux-2.6.3p/drivers/net/ppp_generic.c
> --- linux-2.6.3/drivers/net/ppp_generic.c	2004-02-17 
> 19:59:31.000000000 -0800
> +++ linux-2.6.3p/drivers/net/ppp_generic.c	2004-03-03 

Please CC the PPP maintainer (paulus) and the network developers
(netdev@oss.sgi.com) when modifying PPP.

	Jeff



