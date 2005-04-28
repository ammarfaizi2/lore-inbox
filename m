Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVD1RoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVD1RoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVD1RoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:44:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbVD1RnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:43:24 -0400
Date: Thu, 28 Apr 2005 10:43:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11.7  X.25 : x25tap
Message-ID: <20050428174309.GP23013@shell0.pdx.osdl.net>
References: <1114576764.4789.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114576764.4789.36.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Hendry (ahendry@tusc.com.au) wrote:
> 
> Adds an x25tap module, like ethertap for X.25.

Can this not be done with tun/tap?  Ethertap is gone:

ChangeSet@1.2199.8.34, 2005-03-22 19:20:39-08:00, davem@sunset.davemloft.net
  [NET]: Kill NETLINK_DEV and its only user, ethertap.

  This stuff has been scheduled to die for 2 years.

thanks,
-chris
