Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVEVLVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVEVLVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVEVLVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:21:14 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:20353 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261358AbVEVLVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:21:12 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505221121.j4MBL96E018487@wildsau.enemy.org>
Subject: Re: [PATCH] binutils-2.16.90.0.3: can't compile 2.4.30
To: linux-kernel@vger.kernel.org
Date: Sun, 22 May 2005 13:21:09 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear alessandro,

> http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch

these patches are dated from march, so they are two months old.
do you know why they still are not in the kernel? it's not right
to try to 32bit move a segment register anyway. this should be fixed,
regardless if the majority of users does not have the latest binutils.

best regards,
herbert rosmanith

