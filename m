Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTASUEu>; Sun, 19 Jan 2003 15:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTASUEu>; Sun, 19 Jan 2003 15:04:50 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:51361
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S264665AbTASUEt>; Sun, 19 Jan 2003 15:04:49 -0500
Message-ID: <3E2B06FF.7070507@tupshin.com>
Date: Sun, 19 Jan 2003 12:13:51 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre3-ac oops
References: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>If you got 2.4.21-pre3-ac __free_pages_ok oops, please try this patch.
>
>Hugh
>
>  
>
Looking real good. I just tried this on a machine that couldn't stay up 
for more than an hour with 2.4.21-pre3-ac4. I performed a number of disk 
intensive tasks, any one of which had a near 100% chance of crashing the 
box, and no problem so far. I'll keep running it and let you know if I 
see any problems.

Thanks you.

-Tupshin

