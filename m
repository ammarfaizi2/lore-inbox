Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbULDHgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbULDHgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 02:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbULDHgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 02:36:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:6063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261219AbULDHgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 02:36:06 -0500
Date: Fri, 3 Dec 2004 23:35:52 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: greg@kroah.com, akpm@osdl.org, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Message-ID: <20041203233552.K2357@build.pdx.osdl.net>
References: <200412040239.iB42dPi12085@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200412040239.iB42dPi12085@adam.yggdrasil.com>; from adam@yggdrasil.com on Fri, Dec 03, 2004 at 06:39:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam J. Richter (adam@yggdrasil.com) wrote:
> 	When we first started using Signed-off-by: lines, I did,
> and then somebody commented on it to me in some way that gave me
> the impression that the practice was only for people who "approve"
> patches, but I'm happy to resume adding Signed-off-by: lines to all
> of my patches that are proposed for integration in the future.

It's to document the chain.  So you, as patch author, should sign off
as well as those who "approve" it and send it upstream.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
