Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUCEVBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUCEVBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:01:05 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:21967 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262702AbUCEVBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:01:02 -0500
Message-ID: <4048EA87.1080304@matchmail.com>
Date: Fri, 05 Mar 2004 13:00:55 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp> <c2ambg$9rs$1@terminus.zytor.com>
In-Reply-To: <c2ambg$9rs$1@terminus.zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp>
> By author:    Miles Bader <miles@lsi.nec.co.jp>
> In newsgroup: linux.dev.kernel
> 
>>David Eger <eger@havoc.gtf.org> writes:
>>
>>>arch/v850/kernel/as85ep1.ld	- WTF? comments in some random charset...
>>
>>FWIW, the charset is EUC-JP.
>>
>>Even other files in that same directory aren't consistent, e.g.,
>>as85ep1.c uses ISO-2022-JP.
>>
>>[My fault, but it never really registered on my important-enough-to fix
>>radar (emacs autodetects them all so I never really noticed the
>>discrepancy).]
>>
> 
> 
> OK, this is definitely a good reason to go to UTF-8 across the board.

So when is "less" going to support utf8?  Right now, it just shows 
escape codes... :(
