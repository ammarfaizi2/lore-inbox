Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUIVOXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUIVOXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUIVOXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:23:55 -0400
Received: from mail.dynextechnologies.com ([65.120.73.98]:18561 "EHLO
	mail.dynextechnologies.com") by vger.kernel.org with ESMTP
	id S265887AbUIVOUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:20:20 -0400
Message-ID: <415189DB.6090003@capitalgenomix.com>
Date: Wed, 22 Sep 2004 10:19:07 -0400
From: "Fao, Sean" <Sean.Fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Martin Josefsson <gandalf@wlug.westbo.se>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
References: <1095721742.5886.128.camel@bach>  <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de> <1095803902.1942.211.camel@bach> <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com> <Pine.LNX.4.58.0409221347010.23967@tux.rsn.bth.se> <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0409220800200.2147@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2004 14:20:20.0459 (UTC) FILETIME=[4A9AB3B0:01C4A0AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>I guess I'll have to convert 1340 lines of ipchains commands to
>iptables -yech!
>
>I had convert something to ipchains a couple of years ago.
>That's when I only had to kill-off only about 100 spam-hosts.
>
>Now I gotta convert again. Soon they'll be replacing `ls`
>with `echo *` and nothing will work.
>

iptables is a much better firewall than ipchains and, in my opinion, 
anybody using ipchains should upgrade to iptables.  I, for one, am quite 
pleased to see that ipchains will be removed.

-- 
Sean
