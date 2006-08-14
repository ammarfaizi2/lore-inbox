Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWHMX7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWHMX7m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWHMX7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 19:59:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22464
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751747AbWHMX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 19:59:41 -0400
Date: Sun, 13 Aug 2006 17:00:03 -0700 (PDT)
Message-Id: <20060813.170003.121224409.davem@davemloft.net>
To: qq@inCTV.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 - net/ipv4/route.c/ip_route_output_slow()
From: David Miller <davem@davemloft.net>
In-Reply-To: <44DF4275.8A68AAC@inCTV.ru>
References: <LKML-nat-0.qq@inCTV.ru>
	<44DF4275.8A68AAC@inCTV.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Innocenti Maresin <qq@inCTV.ru>
Date: Sun, 13 Aug 2006 15:17:09 +0000

> Ok, my dear kernel coding gurus.  You have almost nothing to say
> about "internal IP addresses" and "connect() failures".

Probably because you are asking this question on the wrong
list.  The kernel networking developers subscribe to
netdev@vger.kernel.org rather than linux-kernel
