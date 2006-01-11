Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWAKXzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWAKXzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWAKXzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:55:38 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65436
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751157AbWAKXzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:55:37 -0500
Date: Wed, 11 Jan 2006 15:55:38 -0800 (PST)
Message-Id: <20060111.155538.28284376.davem@davemloft.net>
To: bunk@stusta.de
Cc: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       reiga@dspnet.fr.eu.org
Subject: Re: [2.6 patch] arch/sparc64/Kconfig: fix HUGETLB_PAGE_SIZE_64K
 dependencies
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060111234640.GJ29663@stusta.de>
References: <20060111234640.GJ29663@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Thu, 12 Jan 2006 00:46:41 +0100

> This patch fixes a typo in the dependencies of HUGETLB_PAGE_SIZE_64K.
> 
> It might be more logical to rename the HUGETLB_PAGE_SIZE_*K dependencies 
> to HUGETLB_PAGE_SIZE_*KB, but let's fix this bug first.
> 
> This bug was reported by Jean-Luc Leger <reiga@dspnet.fr.eu.org>.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks Adrian.
