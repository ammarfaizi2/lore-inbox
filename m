Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVFOVqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVFOVqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFOVoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:44:06 -0400
Received: from mail.dif.dk ([193.138.115.101]:64728 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261607AbVFOVm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:42:56 -0400
Date: Wed, 15 Jun 2005 23:48:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com,
       ross.biro@gmail.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH][4/4] net: signed vs unsigned cleanup in net/ipv4/raw.c
In-Reply-To: <20050615.144116.41632938.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0506152347270.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
 <20050615.142953.59469324.davem@davemloft.net>
 <Pine.LNX.4.62.0506152338450.3842@dragon.hyggekrogen.localhost>
 <20050615.144116.41632938.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, David S. Miller wrote:

> From: Jesper Juhl <juhl-lkml@dif.dk>
> Date: Wed, 15 Jun 2005 23:40:12 +0200 (CEST)
> 
> > On Wed, 15 Jun 2005, David S. Miller wrote:
> > 
> > > I think I'd prefer that.
> > > 
> > No problem. Here's a replacement patch nr. 4 : 
> 
> Thanks a lot.  All 4 patches applied to my 2.6.13-pending tree.
> 
Great, thanks, 'twas a pleasure working with you :)

-- 
Jesper


