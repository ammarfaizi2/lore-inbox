Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTBFAwx>; Wed, 5 Feb 2003 19:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTBFAwx>; Wed, 5 Feb 2003 19:52:53 -0500
Received: from dial-ctb0170.webone.com.au ([210.9.241.70]:16902 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261427AbTBFAww>;
	Wed, 5 Feb 2003 19:52:52 -0500
Message-ID: <3E41B423.2080309@cyberone.com.au>
Date: Thu, 06 Feb 2003 12:02:27 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.59-mm8 with contest
References: <200302052221.55663.conman@kolivas.net> <3E417624.2762A635@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Con Kolivas wrote:
>
>>..
>>
>>This seems to be creeping up to the same as 2.5.59
>>...
>>and this seems to be taking significantly longer
>>...
>>And this load which normally changes little has significantly different
>>results.
>>
>>
>
>There were no I/O scheduler changes between -mm7 and -mm8.  I
>demand a recount!
>
It would suggest process scheduler changes are making the
difference.

