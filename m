Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269856AbUIDJlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269856AbUIDJlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269854AbUIDJlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:41:37 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:9231 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S269856AbUIDJle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:41:34 -0400
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: vfat problems in 2.6.8.1-mm2+
References: <1094167997.11821.2.camel@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 04 Sep 2004 18:41:20 +0900
In-Reply-To: <1094167997.11821.2.camel@localhost>
Message-ID: <87fz5y5q2n.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg <lkml@metanurb.dk> writes:

> hey, i recently discovered that my kernel completely crashed when
> accessing my vfat partitions under 2.6.8.1-mm2+, somtimes it worked, and
> then suddenly it will just freeze, and i have to hard reset.. its quite
> strange, the files worked, but it would some time crash...
> when booting windows, it scandisked, and said it converted dirs to
> files, and then there were just 32kb files instead of a dir with 7gb..

>From which version do this problem happen?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
