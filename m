Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUBPRZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUBPRZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:25:27 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:55706 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S265826AbUBPRZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:25:26 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
In-Reply-To: <1pTu7-3Ce-7@gated-at.bofh.it>
References: <1pvrI-8bq-29@gated-at.bofh.it> <1pvrI-8bq-31@gated-at.bofh.it> <1pvrJ-8bq-33@gated-at.bofh.it> <1pvrJ-8bq-35@gated-at.bofh.it> <1pvrJ-8bq-37@gated-at.bofh.it> <1pvrJ-8bq-39@gated-at.bofh.it> <1pvrJ-8bq-41@gated-at.bofh.it> <1pvrJ-8bq-43@gated-at.bofh.it> <1pTay-3hc-13@gated-at.bofh.it> <1pTay-3hc-15@gated-at.bofh.it> <1pTay-3hc-11@gated-at.bofh.it> <1pTu7-3Ce-7@gated-at.bofh.it>
Date: Mon, 16 Feb 2004 18:26:47 +0100
Message-Id: <E1AsmW7-0000bV-DM@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 17:10:23 +0100, you wrote in linux.kernel:

>> file and created another with the same name between you calling creat()
>> and doing the readdir(). What would be the use of this, anyway?
> How does the shell do 'echo foo*'?

I fail to see the connection with creat() followed by readdir(). The shell
is surely not expecting the names that follow from the glob expansion to
have any relationship with previous shell operations.

-- 
Ciao,
Pascal
