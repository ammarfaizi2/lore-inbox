Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUARPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 10:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUARPC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 10:02:58 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11528 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261799AbUARPCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 10:02:47 -0500
To: Jens Benecke <jens-usenet@spamfreemail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dangerout FAT32 filesystem bug
References: <1383334.RWlT9uk5eq@spamfreemail.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 19 Jan 2004 00:01:47 +0900
In-Reply-To: <1383334.RWlT9uk5eq@spamfreemail.de>
Message-ID: <87isj9712c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Benecke <jens-usenet@spamfreemail.de> writes:

> Hi,
> 
> I didn't find anything in the changelog for 2.6.[01] and 2.4.2[2345]:
> 
> has the FAT32 FS bug mentioned (and successfully fixed/patched) in 
> 
> http://seclists.org/lists/linux-kernel/2003/Dec/1127.html
> 
> been included in the mainstream kernel? It destroys data on big FAT32
> partitions, which is very critical for people with big external harddisks
> trying to exchange data between Linux and Windows systems.

2.6 was already fixed several months ago.

For 2.4, patch submited.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
