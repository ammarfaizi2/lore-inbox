Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCMNpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCMNpX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCMNpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:45:23 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59922 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261254AbVCMNpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:45:17 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: Andrew Morton <akpm@osdl.org>, <chaffee@bmrc.berkeley.edu>,
       <mc@cs.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops
 (msdos and vfat, 2.6.11)
References: <Pine.GSO.4.44.0503122146410.4831-100000@elaine24.Stanford.EDU>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Mar 2005 22:45:02 +0900
In-Reply-To: <Pine.GSO.4.44.0503122146410.4831-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Sat, 12 Mar 2005 21:53:54 -0800 (PST)")
Message-ID: <87oedn1wyp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

> Can you be a little bit more specific?

Please try

kernel:
  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.gz
                       +
  http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.11-bk7.bz2
  or later

dosfstools:
  http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
