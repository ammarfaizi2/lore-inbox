Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311929AbSCTSdR>; Wed, 20 Mar 2002 13:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293043AbSCTSdH>; Wed, 20 Mar 2002 13:33:07 -0500
Received: from freeside.toyota.com ([63.87.74.7]:17936 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S311928AbSCTSdA>; Wed, 20 Mar 2002 13:33:00 -0500
Message-ID: <3C98D5D0.1040107@lexus.com>
Date: Wed, 20 Mar 2002 10:32:48 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shura <shura@tibc.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: kfree_skb on hard IRQ c019aa41
In-Reply-To: <17800.020320@tibc.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a shot in the dark, are you using
ipchains emulation?

Joe

shura wrote:

>What does it mean?
>I'm testing computer with 3 3Com 905B,multiport Digi AccelePort Xp,
>256 Mb ram ,red hat 7.1, kernel 2.4.17 (later try 2.4.8,2.4.10), during working i
>receives this messages and see memory leakage, after ~4 hours system
>stopping. Kernel assembled with support driver 3Com 905B, and iptables
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


