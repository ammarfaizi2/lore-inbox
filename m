Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbSJBMbr>; Wed, 2 Oct 2002 08:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbSJBMbr>; Wed, 2 Oct 2002 08:31:47 -0400
Received: from web9603.mail.yahoo.com ([216.136.129.182]:60057 "HELO
	web9603.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263079AbSJBMbq>; Wed, 2 Oct 2002 08:31:46 -0400
Message-ID: <20021002123715.45465.qmail@web9603.mail.yahoo.com>
Date: Wed, 2 Oct 2002 05:37:15 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: 2.4.18+IPv6+IPV6_ADDRFORM
To: linux-kernel@vger.kernel.org
In-Reply-To: <20021002.182006.1021932192.yoshfuji@wide.ad.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>IPV6_ADDRFORM is deprecated.
>I believe that it should be removed.

Shouldn't we correct it in 2.4 and drop it in 2.5 ? 

If the above assumption is correct...

>1) should the level really be IPPROTO_IPV6?
>2) do other platforms use IPPROTO_IP to retrieve this
>option or said another way, is the behavior observed
>in Linux portable?
>3) should the returned value be 0 & 1 or AF_INET &
>AF_INET6?

>>Also, the Sus v3, states there is a socket option:
>>level IPPROTO_IPV6, option IPV6_V6ONLY.
>
>We, USAGI Project, have implementation for it,
>and we are about to contribute it here.

Great.

Thanks,
Steve Grubb


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
