Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTIGR7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTIGR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:59:22 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:46350
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263412AbTIGR7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:59:19 -0400
Message-ID: <3F5B71F3.6040009@cyberone.com.au>
Date: Mon, 08 Sep 2003 03:59:15 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       David Nielsen <Lovechild@foolclan.com>
Subject: Re: [PATCH] Nick's scheduler policy v13
References: <1062938059.3485.2.camel@pilot.stavtrup-st.dk> <3F5B6727.2010201@cyberone.com.au>
In-Reply-To: <3F5B6727.2010201@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

> A random priority / nice fixes noticed by Greg Wolledge. Due to bigger
> priority range. A few other random things.
>
> I apologise for continually posting this patch. I have taken on a number
> of other scheduler improvements (mostly SMP/NUMA balancing), so the 
> rollup
> is growing. I'll refrain from posting it again till I find some webspace
> to put it up.


David Nielsen has offered to host my stuff for a while. Its done in a
similar way to Andrew Morton's patch sets.

http://userportal.iha.dk/~01876/nickpatches/v13b/


