Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbTIMCGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTIMCGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:06:46 -0400
Received: from dyn-ctb-210-9-245-223.webone.com.au ([210.9.245.223]:11524 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261993AbTIMCGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:06:45 -0400
Message-ID: <3F627BAC.5040706@cyberone.com.au>
Date: Sat, 13 Sep 2003 12:06:36 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Nick's scheduler policy v15
References: <200309121839.h8CIdao22695@mail.osdl.org>
In-Reply-To: <200309121839.h8CIdao22695@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cliff White wrote:

>>Hi,
>>http://www.kerneltrap.org/~npiggin/v15/
>>
>>
>
>Here are results for several recent kernels for comparison.
>the sched-rollup-nopolicy tests are still running. 
>Performance of v15 suffers as number of CPU's increase.
>At 8 cpu's, delta is noticeable vs stock -test5
>cliffw
>

OK, so it hasn't crashed? Do you have the profiles up?

Thanks,
Nick

