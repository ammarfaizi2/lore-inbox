Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWAQXPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWAQXPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAQXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:15:43 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64213
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964791AbWAQXPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:15:42 -0500
Date: Tue, 17 Jan 2006 15:15:10 -0800 (PST)
Message-Id: <20060117.151510.125926130.davem@davemloft.net>
To: akpm@osdl.org
Cc: adobriyan@gmail.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, asun@darksunrising.com
Subject: Re: PATCH: cassini printk format warning
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060117134010.1e48fd79.akpm@osdl.org>
References: <1137523175.14135.84.camel@localhost.localdomain>
	<20060117213442.GA22002@mipter.zuzino.mipt.ru>
	<20060117134010.1e48fd79.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Jan 2006 13:40:10 -0800

> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > 	"%llx", (unsigned long long)u64
> > 
> > is the warningless way on all archs.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/cassini-printk-fix.patch

I've added this to my tree, thanks Andrew.

