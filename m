Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269891AbRHJCDn>; Thu, 9 Aug 2001 22:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269893AbRHJCDd>; Thu, 9 Aug 2001 22:03:33 -0400
Received: from james.kalifornia.com ([208.179.59.2]:44912 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S269891AbRHJCDa>; Thu, 9 Aug 2001 22:03:30 -0400
Message-ID: <3B7340EA.5050507@blue-labs.org>
Date: Thu, 09 Aug 2001 22:03:22 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rainer Mager <rvm@gol.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [somewhat OT] connecting to a box behind a NAT router
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGIEICELAA.rvm@gol.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, if you use ssh+pppd you can such a thing. Standard routing, no, the
NAT make it unusable. What I would have done (as I do for my home
network, is make a linux router and use a standard *DSL modem. Much
better all around.

-d

Rainer Mager wrote:

>Hi all,
>
>	I'm about to get ADSL installed for my home Internet connection and have
>chosen to do this via an ADSL router (as opposed to a modem). The router
>will have a static/global IP address but everything behind it will be
>connecting through the router via NAT. So, my question is, is there any way
>to get into (telnet or ssh) my box behind the router from outside?
>	Is there some sort of tunneling protocol/tool to do this? If so, what
>happens if I want to connect two boxes is the same situation (behind NAT
>routers)? Is is still possible? Is is interoperable with Windows and Linux?
>
>	Any ideas would be greatly appreciated.
>
>
>Thanks in advance,
>
>--Rainer
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



