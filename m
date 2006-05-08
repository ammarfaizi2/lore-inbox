Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWEHJJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWEHJJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 05:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWEHJJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 05:09:31 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:62631 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S1750819AbWEHJJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 05:09:31 -0400
Message-ID: <445F0A99.3050700@blackdown.de>
Date: Mon, 08 May 2006 11:08:41 +0200
From: Juergen Kreileder <jk@blackdown.de>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Amin Azez <azez@ufomechanic.net>
CC: "David S. Miller" <davem@davemloft.net>, sfrost@snowman.net,
       gcoady.lk@gmail.com, laforge@netfilter.org, jesper.juhl@gmail.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507093640.GF11191@w.ods.org>	<egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>	<20060508050748.GA11495@w.ods.org>	<20060507.224339.48487003.davem@davemloft.net> <445F02F1.1090604@ufomechanic.net>
In-Reply-To: <445F02F1.1090604@ufomechanic.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amin Azez wrote:
> David S. Miller wrote:
>> From: Willy Tarreau <willy@w.ods.org>
>> Date: Mon, 8 May 2006 07:07:48 +0200
>>
>>> I wonder how such unmaintainable code has been merged in the first
>>> place. Obviously, Davem has never seen it !
>> Oh I've seen ipt_recent.c, it's one huge pile of trash
>> that needs to be rewritten.  It has all sorts of problems.
>>
>> This is well understood on the netfilter-devel list and
>> I am to understand that someone has taken up the task to
>> finally rewrite the thing.
> 
> 
> Is that Juergen.Kreileder@empolis.com ?

Please use jk@blackdown.de (@empolis.com is just an address at
a client's site).

> ...just checking... he seemed to volunteer in December

but not for a rewrite.  Anyhow, if somebody is planning to do that
I'll gladly help.

> last year but Stephen Frost has been taking recent questions.


	Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
