Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVEUW76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVEUW76 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 18:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVEUW76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 18:59:58 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:7553 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261227AbVEUW75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 18:59:57 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505212259.j4LMxqAS017253@wildsau.enemy.org>
Subject: Re: [PATCH] binutils-2.16 & kernel-2.6.11.10
In-Reply-To: <428FB853.8070205@ppp0.net>
To: Jan Dittmer <jdittmer@ppp0.net>
Date: Sun, 22 May 2005 00:59:50 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> http://www.kernel.org/pub/linux/devel/binutils/linux-2.6-seg-5.patch
> http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch
> 
> should probably fix that.

interesting, that's the same patch (s/movl/movw/), but it is date
from *march* 2005.

why is this not in the kernel source yet? It is definitely not
okay to "movl" a segreg.

regards,
h.rosmanith

