Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266496AbRGLSXC>; Thu, 12 Jul 2001 14:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266499AbRGLSWw>; Thu, 12 Jul 2001 14:22:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22538 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266496AbRGLSWe>; Thu, 12 Jul 2001 14:22:34 -0400
Subject: Re: [PATCH] ext2 cleanups
To: adilger@turbolinux.com (Andreas Dilger)
Date: Thu, 12 Jul 2001 19:22:13 +0100 (BST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel development list),
        ext2-devel@lists.sourceforge.net (Ext2 development mailing list)
In-Reply-To: <200107112229.f6BMT5ls009821@webber.adilger.int> from "Andreas Dilger" at Jul 11, 2001 04:29:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Kl6L-0006Zk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch cleans up the ext2 code in various places.  It is mostly cosmetic
> changes to comments, avoiding lines > 80 columns, removing redundant #ifdef
> lines, etc.  It also adds the new COMPAT flags from the current e2fsprogs
> into include/linux/ext2_fs.h.

ANy reason for not delaying this until 2.5.0 ? (ie any bug fixes)
