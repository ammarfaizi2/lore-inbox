Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbULRHzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbULRHzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbULRHzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:55:14 -0500
Received: from havoc.gtf.org ([63.115.148.101]:5078 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262850AbULRHzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:55:11 -0500
Date: Sat, 18 Dec 2004 02:55:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Scott Feldman <sfeldma@pobox.com>
Cc: Ed L Cashin <ecashin@coraid.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.10-rc3-bk11
Message-ID: <20041218075509.GA3316@havoc.gtf.org>
References: <87k6rhc4uk.fsf@coraid.com> <1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103356085.3369.140.camel@sfeldma-mobl.dsl-verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 11:48:05PM -0800, Scott Feldman wrote:
> On Fri, 2004-12-17 at 07:38, Ed L Cashin wrote:
> 
> > +       ETH_P_AOE = 0x88a2,
> 
> include/linux/if_ether.h already defines this as ETH_P_EDP2=0x88A2; use
> that.

If my aging memory serves me, EDP2 == AOE.

	Jeff



