Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVHUInr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVHUInr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVHUInr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 04:43:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750836AbVHUInq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 04:43:46 -0400
Date: Sun, 21 Aug 2005 01:38:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: netdev@vger.kernel.org, linux-tr@linuxtr.net, mikep@linuxtr.net,
       jgarzik@pobox.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc6] net/802/tr: use interrupt-safe locking
Message-Id: <20050821013855.6263eac9.akpm@osdl.org>
In-Reply-To: <200508172148.j7HLmPAt005857@death.nxdomain.ibm.com>
References: <20050817204959.GA20186@tuxdriver.com>
	<200508172148.j7HLmPAt005857@death.nxdomain.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Vosburgh <fubar@us.ibm.com> wrote:
>
>  >FWIW, this patch is currently being carried in the Fedora and RHEL
>  >kernels.  It certainly looks like it is necessary to me.  Can we get
>  >some movement on this?
> 
>  	It's in the SuSE kernel as well.

For how long has this fix been in the vendor kernels?

Could someone please tell us why there are unmerged bugfixes in vendor
kernels?

Are there any more?
