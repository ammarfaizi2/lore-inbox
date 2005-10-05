Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVJETBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVJETBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVJETBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:01:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030285AbVJETBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:01:47 -0400
Date: Wed, 5 Oct 2005 12:00:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Mitsuru KANDA / =?utf-8?B?56We55SwIOWFhQ==?= <mk@karaba.org>
Cc: "David S. Miller" <davem@davemloft.net>, chuckw@quantumlinux.com,
       chrisw@osdl.org, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mk@linux-ipv6.org
Subject: Re: [PATCH 07/10] [PATCH] check connect(2) status for IPv6 UDP socket
Message-ID: <20051005190059.GN7991@shell0.pdx.osdl.net>
References: <20050930022016.640197000@localhost.localdomain> <20050930022239.411732000@localhost.localdomain> <Pine.LNX.4.63.0509292318320.29997@localhost.localdomain> <20050930.001025.86739685.davem@davemloft.net> <87zmpurf2o.wl%mk@karaba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zmpurf2o.wl%mk@karaba.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mitsuru KANDA / 神田 充 (mk@karaba.org) wrote:
> Sorry for log silence, I was on a business trip in last week.
> 
> I recreate a patch (of course, which have been tested) ASAP.

BTW, we dropped this one, since it had possible leak in it.  I'll let
you and DaveM decide when the updated one is ready for -stable.

thanks,
-chris
