Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935663AbWLDKVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935663AbWLDKVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935664AbWLDKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:21:10 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:44661 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S935663AbWLDKVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:21:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YvaFMTxfpQfS0PS/KfQYre71s3WLEcCJeykzDFI3+FX8+p2CwRe1v9ox7m9xB3I6gbSRZP+B//trE0XWVtLDbJLCf7sDgyuOK+9X+uUlTe0XuD0UTRcQRsQPnaYoQOJfABcYgztNcfulY/H0B4bJce7z23Ze2YcHT6ClCZa4Ddk=  ;
X-YMail-OSG: GNNx1R0VM1kCQHs3xFAIa5j.f1M1kW78JfTQ6h1QCqGZrzAN3yZ3dnabQKsKdYRWa_sEhuDMvwZWPlhqX6jZ3Nx5jzTQd8fmb9giFAFpgWrFl2DUdRsWxONG5FO29PrrKnbBR88MBsxMig--
Message-ID: <4573F665.4080105@yahoo.com.au>
Date: Mon, 04 Dec 2006 21:20:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Fengguang Wu <fengguang.wu@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: drop_pagecache: Possible circular locking dependency
References: <365219737.01594@ustc.edu.cn> <20061204003217.c0f05e00.akpm@osdl.org> <365225031.05635@ustc.edu.cn>
In-Reply-To: <365225031.05635@ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fengguang Wu wrote:

> I'd like to move this sysctl interface to the upcoming /proc/filecache. 
> Being a module, it helps reduce the kernel size :)

What's /proc/filecache?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
