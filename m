Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVJETGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVJETGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbVJETGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:06:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52693
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030327AbVJETGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:06:02 -0400
Date: Wed, 05 Oct 2005 12:05:16 -0700 (PDT)
Message-Id: <20051005.120516.59092768.davem@davemloft.net>
To: chrisw@osdl.org
Cc: mk@karaba.org, chuckw@quantumlinux.com, linux-kernel@vger.kernel.org,
       stable@kernel.org, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, rdunlap@xenotime.net, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mk@linux-ipv6.org
Subject: Re: [PATCH 07/10] [PATCH] check connect(2) status for IPv6 UDP
 socket
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051005190059.GN7991@shell0.pdx.osdl.net>
References: <20050930.001025.86739685.davem@davemloft.net>
	<87zmpurf2o.wl%mk@karaba.org>
	<20051005190059.GN7991@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@osdl.org>
Date: Wed, 5 Oct 2005 12:00:59 -0700

> * Mitsuru KANDA (mk@karaba.org) wrote:
> > Sorry for log silence, I was on a business trip in last week.
> > 
> > I recreate a patch (of course, which have been tested) ASAP.
> 
> BTW, we dropped this one, since it had possible leak in it.  I'll let
> you and DaveM decide when the updated one is ready for -stable.

Will do, thanks Chris.
