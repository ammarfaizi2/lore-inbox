Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbULZLAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbULZLAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbULZLAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:00:05 -0500
Received: from mail.linicks.net ([217.204.244.146]:2052 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261622AbULZLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:00:01 -0500
From: Nick Warne <nick@linicks.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.10 typo in include/linux/netfilter.h
Date: Sun, 26 Dec 2004 10:59:57 +0000
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412260917.38717.nick@linicks.net> <20041226023200.1bbf594d.davem@davemloft.net>
In-Reply-To: <20041226023200.1bbf594d.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412261059.57661.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 December 2004 10:32, David S. Miller wrote:

> > Line 161
> >
> > /* Call setsockopt() */
> > int nf_setsockopt(struct sock *sk, int pf, int optval, char __user *opt,
> >                   int len(;  <-------
>
> That doesn't exist in the 2.6.10 sources.  Something is
> up with the source tree you have.  Lots of people would
> be complaining if this simplistic error were actually
> in the real 2.6.10 tree.

Yes, I thought strange, but this is the full tar.bz2 from kernel.org - I 
downloaded this morning about 2 hours ago.

http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2

Nick

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
