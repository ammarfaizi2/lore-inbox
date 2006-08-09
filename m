Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWHIF4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWHIF4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWHIF4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:56:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24451
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030506AbWHIF4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:56:52 -0400
Date: Tue, 08 Aug 2006 22:56:53 -0700 (PDT)
Message-Id: <20060808.225653.85409729.davem@davemloft.net>
To: phillips@google.com
Cc: johnpol@2ka.mipt.ru, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: David Miller <davem@davemloft.net>
In-Reply-To: <44D97822.5010007@google.com>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	<20060809054648.GD17446@2ka.mipt.ru>
	<44D97822.5010007@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Tue, 08 Aug 2006 22:52:34 -0700

> Agreed.  But probably more intrusive than davem would be happy with
> at this point.

I'm much more happy with Evgeniy's network tree allocator, which has a
real design and well thought our long term consequences, than your
work.

