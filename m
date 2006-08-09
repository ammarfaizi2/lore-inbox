Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWHIFzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWHIFzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbWHIFzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:55:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22659
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030502AbWHIFzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:55:36 -0400
Date: Tue, 08 Aug 2006 22:55:37 -0700 (PDT)
Message-Id: <20060808.225537.112622421.davem@davemloft.net>
To: phillips@google.com
Cc: jeff@garzik.org, a.p.zijlstra@chello.nl, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 8/9] 3c59x driver conversion
From: David Miller <davem@davemloft.net>
In-Reply-To: <44D977D8.5070306@google.com>
References: <20060808193447.1396.59301.sendpatchset@lappy>
	<44D9191E.7080203@garzik.org>
	<44D977D8.5070306@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Tue, 08 Aug 2006 22:51:20 -0700

> Elaborate please.  Do you think that all drivers should be updated to
> fix the broken blockdev semantics, making NETIF_F_MEMALLOC redundant?
> If so, I trust you will help audit for it?

I think he's saying that he doesn't think your code is yet a
reasonable way to solve the problem, and therefore doesn't belong
upstream.
