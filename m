Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbUJaD10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUJaD10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 23:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbUJaD10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 23:27:26 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:40210 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261486AbUJaD1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 23:27:24 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill fatfs_syms.c
References: <20041030014522.GH6677@stusta.de>
	<20041030063925.GB22838@infradead.org>
	<20041030213343.GZ4374@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 31 Oct 2004 12:25:34 +0900
In-Reply-To: <20041030213343.GZ4374@stusta.de> (Adrian Bunk's message of
 "Sat, 30 Oct 2004 23:33:43 +0200")
Message-ID: <87k6t74lht.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Sat, Oct 30, 2004 at 07:39:25AM +0100, Christoph Hellwig wrote:
>>...
>> just move this to inode.c
>
> Thanks for this suggestion.
> An updated patch is below.

Thanks. I'll submit after 2.6.10.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
