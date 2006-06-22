Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbWFVEFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWFVEFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWFVEFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:05:43 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:43653 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932769AbWFVEFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:05:42 -0400
Message-ID: <449A16FC.9030300@ak.jp.nec.com>
Date: Thu, 22 Jun 2006 13:05:16 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
References: <449794BB.8010108@ak.jp.nec.com>	<20060619234212.b95e5734.akpm@osdl.org>	<4497A34C.2000104@ak.jp.nec.com>	<449A0967.2020701@ak.jp.nec.com> <20060621203550.b14e867a.akpm@osdl.org>
In-Reply-To: <20060621203550.b14e867a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 22 Jun 2006 12:07:19 +0900
> KaiGai Kohei <kaigai@ak.jp.nec.com> wrote:
> 
>> The seriese of patches fixes some process accounting bugs.
> 
> OK, thanks for splitting those up.  A few patch-protocol things:
> 
> - Please make the email Subject: reflect the patch contents - all three
>   patches here were called "Re: Add pacct_struct to fix some pacct bugs."
> 
> - Please don't indent the changlogs by five spaces.  Start in column zero.
> 
> - Your email client performs space-stuffing, which corrupts the patches. 
>   I fixed them all by hand.
> 
>   I don't know if it's possible to prevent thunderbird from doing this
>   (my mozilla bugzilla record on this has to be three years old, and is
>   still open).  You might have to use text/plain attachments in the future.

Oops, I'm sorry for sending you a trouble.
I'll pay attention about those manners.

Thanks,
-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
