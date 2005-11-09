Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVKIF1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKIF1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 00:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKIF1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 00:27:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9128
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932352AbVKIF1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 00:27:52 -0500
Date: Tue, 08 Nov 2005 21:27:50 -0800 (PST)
Message-Id: <20051108.212750.41206070.davem@davemloft.net>
To: akpm@osdl.org
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org, herbert@gondor.apana.org.au
Subject: Re: Linux 2.6.14.1
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051108211354.546e0163.akpm@osdl.org>
References: <20051109010729.GA22439@kroah.com>
	<20051108211354.546e0163.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 8 Nov 2005 21:13:54 -0800

> Greg KH <gregkh@suse.de> wrote:
> >
> > We (the -stable team) are announcing the release of the 2.6.14.1 kernel.
> 
> We need the fix for the net-drops-zero-length-udp-messages bug which broke
> bind and traceroute.

Yes, and I was pretty sure I saw Herbert submit this to
stable@kernel.org even.

In any event, yes please put that in.
