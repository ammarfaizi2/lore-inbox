Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVCIVlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVCIVlC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCIViJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:38:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:31190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262487AbVCIVhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:37:07 -0500
Date: Wed, 9 Mar 2005 13:36:55 -0800
From: Chris Wright <chrisw@osdl.org>
To: DHollenbeck <dick@softplc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x.y gatekeeper discipline
Message-ID: <20050309213655.GY28536@shell0.pdx.osdl.net>
References: <422F66C6.50208@softplc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422F66C6.50208@softplc.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* DHollenbeck (dick@softplc.com) wrote:
> [PATCH] drivers/net/via-rhine.c: make a variable static const
> 
> This patch makes a needlessly global variable static const.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> ----------------------------------
> 
> It's possible I simply don't get it, but the above description of a 
> patch hardly seems like it would qualify for the intentions of the 
> 2.6.x.y series.

I think you've confused something.  This patch is not in -stable.
Here's current listing:

http://linux-release.bkbits.net:8080/linux-2.6.11/ChangeSet@1.2079..1.2085

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
