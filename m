Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVLWFFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVLWFFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 00:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVLWFFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 00:05:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17545
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030437AbVLWFFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 00:05:36 -0500
Date: Thu, 22 Dec 2005 21:04:23 -0800 (PST)
Message-Id: <20051222.210423.48382393.davem@davemloft.net>
To: bunk@stusta.de
Cc: gmack@innerfire.net, wli@holomorphy.com, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [2.6 patch] introduce a SPARC Kconfig symbol
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051223021526.GG27525@stusta.de>
References: <20051217141049.GP23349@stusta.de>
	<20051219.145254.33863414.davem@davemloft.net>
	<20051223021526.GG27525@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Fri, 23 Dec 2005 03:15:26 +0100

> Introduce a Kconfig symbol SPARC that is defined on both the sparc and 
> sparc64 architectures.
> 
> This symbol makes some dependencies more readable.
> 
> Except for all bugs this patch deliberately introduces ;-) it shouldn't 
> cause any visible change.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

:-)  Applied, thanks Adrian.
