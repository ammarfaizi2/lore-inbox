Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312904AbSCZBBA>; Mon, 25 Mar 2002 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312903AbSCZBAx>; Mon, 25 Mar 2002 20:00:53 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:41441 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312905AbSCZBAl>; Mon, 25 Mar 2002 20:00:41 -0500
Message-ID: <3C9FC835.8040906@ngforever.de>
Date: Mon, 25 Mar 2002 18:00:37 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mdrobnak@optonline.net, linux-kernel@vger.kernel.org
Subject: Re: More observations regarding IPv6 on PPC platform.
In-Reply-To: <3C9FAA3A.8000701@optonline.net>	<3C9FC110.8010100@ngforever.de> <20020325.163739.40148174.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    tcpdump keeps ethn in promiscuous mode. Maybe this is what was expected?
>    
> Smells like a multicast bug in the network driver/card.
An userland way to find out is to check if networking works
as expected if he's running other programs that keep the
network in promisc mode, like nmap.

Thunder
-- 
Thunder from the hill.
Citizen of our universe.

