Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUIPR7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUIPR7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268410AbUIPR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:58:36 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:35781 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268270AbUIPR6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:58:12 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Jedi/Sector One <j@pureftpd.org>
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 14:57:59 -0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx> <20040916173732.GA31672@c9x.org>
In-Reply-To: <20040916173732.GA31672@c9x.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161458.00031.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jedi/Sector One wrote:
> On Thu, Sep 16, 2004 at 01:45:55PM -0300, Norberto Bensa wrote:
> > Andrew Morton wrote:
> > > +tune-vmalloc-size.patch
> >
> > This one of course breaks nvidia's binary driver; so nvidia users should
> > do a "patch -Rp1" to revert it.
>
> http://00f.net/blogs/index.php/2004/09/16/nvidia_kernel_module_and_linux_2_
>6_9_rc2

Thanks. Actually, that was going to be my next fix, but ATM I'm trying to get 
a work done for my CS class.

Best regards,
Norberto
