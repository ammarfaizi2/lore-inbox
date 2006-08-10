Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWHJGMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWHJGMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbWHJGMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:12:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24264
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161059AbWHJGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:12:37 -0400
Date: Wed, 09 Aug 2006 23:12:44 -0700 (PDT)
Message-Id: <20060809.231244.35509467.davem@davemloft.net>
To: nigelenki@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does Linux do RTTM?
From: David Miller <davem@davemloft.net>
In-Reply-To: <44DACA22.6090701@comcast.net>
References: <44DACA22.6090701@comcast.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Richard Moser <nigelenki@comcast.net>
Date: Thu, 10 Aug 2006 01:54:42 -0400

> Sorry for the dumb questions but Google is being massively bad at "tell
> me about an obscure feature of the Linux kernel that nobody cares about"
> today :)

When I type "Linux RTT measurement" to google, the following
very authoritative paper on Linux's TCP congestion control
shows up on the very first page:

http://www.cs.helsinki.fi/research/iwtcp/papers/linuxtcp.pdf

You should try a little bit harder with google next time, and
also ask your question on a more appropriate list such as
netdev@vger.kernel.org which is where the networking developers
are subscribed.
