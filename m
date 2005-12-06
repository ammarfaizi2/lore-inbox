Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVLMTta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVLMTta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbVLMTta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:49:30 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:5454 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932594AbVLMTtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:49:23 -0500
Message-ID: <4396036C.70107@tmr.com>
Date: Tue, 06 Dec 2005 16:32:28 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bharath Ramesh <krosswindz@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>	 <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>	 <c775eb9b0512011651kb0e1cb4xf79ca20372f6d76e@mail.gmail.com>	 <c775eb9b0512011712x2f4f2f44t4cd11d5d6f60a9d8@mail.gmail.com>	 <a762e240512011742p681df3bdic16598a85926dd67@mail.gmail.com>	 <c775eb9b0512020732v3f41f91fpb3b4b61b0b539d92@mail.gmail.com>	 <a762e240512021407p5a31c0daid902352625701ca2@mail.gmail.com>	 <c775eb9b0512021534y693f3bf3i4b85b7cb0dcb08b6@mail.gmail.com>	 <a762e240512021701q4ea436d9u563704c4daeb7584@mail.gmail.com> <c775eb9b0512021806wb8bb3fdh9cd0a0a80fead69@mail.gmail.com>
In-Reply-To: <c775eb9b0512021806wb8bb3fdh9cd0a0a80fead69@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Ramesh wrote:
> I have attached the kernel config. I will enable debugging and rebuild
> the kernel soon and send in the latest dmesg soon.
> 
> Thanks,
> 
> Bharath

I'm not at all an expert on x86_64, but I notice the NUMA is not set in 
this config, and I have a similar config from another post with DOES 
work, and it has NUMA on (four way only, dual dual-core).

I have no idea if that can be useful, but if you're still out of ideas 
you might try it.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

