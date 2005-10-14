Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbVJNU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbVJNU6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJNU6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 16:58:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56779
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750790AbVJNU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 16:57:59 -0400
Date: Fri, 14 Oct 2005 13:57:51 -0700 (PDT)
Message-Id: <20051014.135751.78051480.davem@davemloft.net>
To: yoshfuji@wide.ad.jp
Cc: yzcorp@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]The type of inet6_ifinfo_notify event in
 addrconf_ifdown().
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051014.195315.106624870.yoshfuji@wide.ad.jp>
References: <434F8B23.7090201@gmail.com>
	<20051014.195315.106624870.yoshfuji@wide.ad.jp>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@wide.ad.jp>
Date: Fri, 14 Oct 2005 19:53:15 +0900 (JST)

> Acked-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied.  I also took the liberty of fixing the "Step 5"
comment above, it should be "Step 6" :-)

Yan, please fix your patch postings.  Your email client
adds newlines, and changes tabs into spaces, totally corrupting
your patches.  I have to apply every one of your patches by
hand because of this.

To be honest, gmail has been shown to be a very unusable place
from which to send patches.  There are certain kinds of outgoing
text mangling that I do not know if they even allow to disable.

Thanks.
