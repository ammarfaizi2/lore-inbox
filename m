Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268134AbUIMPCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268134AbUIMPCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIMPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:01:24 -0400
Received: from asplinux.ru ([195.133.213.194]:26383 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267566AbUIMOv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:51:58 -0400
Message-ID: <4145B6C2.30503@sw.ru>
Date: Mon, 13 Sep 2004 19:03:30 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Roel van der Made <roel@telegraafnet.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru> <20040913092443.GA19437@elte.hu> <20040913133437.GW3951@telegraafnet.nl> <20040913133847.GA9157@elte.hu> <20040913134215.GY3951@telegraafnet.nl>
In-Reply-To: <20040913134215.GY3951@telegraafnet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roel van der Made wrote:
> On Mon, Sep 13, 2004 at 03:38:47PM +0200, Ingo Molnar wrote:
> 
>>* Roel van der Made <roel@telegraafnet.nl> wrote:
>>
>>>>>the last check ensures that we are still hashed and this check is more 
>>>>>straithforward for understanding, agree?
>>>>
>>>>yep - please send a new patch to Andrew.
>>>
>>>I'll be awaiting the patch and give it a shot.
>>>Thanks all for the feedback.
>>
>>you can try my patch too, it will do the job of fixing the bug. The
>>other changes we talked about are only improvements to the debugging
>>infrastructure.
> 

> Saw there's an mm5 release already, is your patch included in this one
> also?
I've checked that -mm5 contains fix to the BUG() you reported.
It's slight different (looks almost like Ingo Molnar patch), but it's there.

Kirill

