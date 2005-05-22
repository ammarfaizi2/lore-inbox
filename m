Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVEVKwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEVKwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVEVKwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 06:52:16 -0400
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:15338 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261230AbVEVKwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 06:52:05 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binutils-2.16 & kernel-2.6.11.10
Date: Sun, 22 May 2005 11:51:46 +0100
User-Agent: KMail/1.7.2
References: <200505212259.j4LMxqAS017253@wildsau.enemy.org>
In-Reply-To: <200505212259.j4LMxqAS017253@wildsau.enemy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505221151.46592.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 May 2005 23:59, Herbert Rosmanith wrote:
> > http://www.kernel.org/pub/linux/devel/binutils/linux-2.6-seg-5.patch
> > http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> >
> > should probably fix that.
>
> interesting, that's the same patch (s/movl/movw/), but it is date
> from *march* 2005.
>
> why is this not in the kernel source yet? It is definitely not
> okay to "movl" a segreg.
>

I'd also like to know the status of these patches; I've avoided the last 
couple binutils upgrades because of HJL's attached kernel patches and implied 
Linux build problems.
#

Andrew Walrond
