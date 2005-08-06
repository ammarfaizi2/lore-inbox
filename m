Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVHFMJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVHFMJV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVHFMJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:09:20 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:7471 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S262334AbVHFMJO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:09:14 -0400
Message-ID: <42F4A866.8060902@home.se>
Date: Sat, 06 Aug 2005 14:09:10 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, ak@suse.de,
       akpm@osdl.org, mingo@elte.hu, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netpoll can lock up on low memory.
References: <1123287835.18332.110.camel@localhost.localdomain>	 <20050806015310.GA8074@waste.org>	 <1123295548.18332.126.camel@localhost.localdomain>	 <20050806.024636.28814830.davem@davemloft.net> <1123322240.18332.131.camel@localhost.localdomain>
In-Reply-To: <1123322240.18332.131.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> In my last email, I stated that this discussion seems to have
> demonstrated that the e1000 driver's netpoll is indeed broken, and needs
> to be fixed.  I submitted eariler a patch for this, but it's untested
> and someone who owns an e1000 needs to try it.

I can test this, but not right now: Im trying, again, to find my hard 
lockup issue, and so I will try to run this machine until it locks up. 
It lasted 9 days at one time, so it could potentially take some time, 
I'm afraid.

---
John Bäckstrand
