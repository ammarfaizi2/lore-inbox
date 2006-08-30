Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWH3WDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWH3WDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWH3WDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 18:03:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7080
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932157AbWH3WDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 18:03:36 -0400
Date: Wed, 30 Aug 2006 15:03:37 -0700 (PDT)
Message-Id: <20060830.150337.115914733.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] net/sched/act_simple.c: make struct simp_hash_info
 static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060830203507.GL18276@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060830203507.GL18276@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Wed, 30 Aug 2006 22:35:07 +0200

> On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm2:
> >...
> >  git-net.patch
> >...
> >  git trees
> >...
> 
> This patch makes the needlessly global struct simp_hash_info static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
