Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312893AbSCZAaj>; Mon, 25 Mar 2002 19:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312894AbSCZAa3>; Mon, 25 Mar 2002 19:30:29 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:8720 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312893AbSCZAaM>; Mon, 25 Mar 2002 19:30:12 -0500
Message-ID: <3C9FC110.8010100@ngforever.de>
Date: Mon, 25 Mar 2002 17:30:08 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Drobnak <mdrobnak@optonline.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: More observations regarding IPv6 on PPC platform.
In-Reply-To: <3C9FAA3A.8000701@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Drobnak wrote:
> While I was attempting to debug a little bit, I installed tcpdump to see 
> if it was even seeing the router advertisements...Apparently it was..
> 
> On top of that, if you keep tcpdump running, IPv6 works fine!
tcpdump keeps ethn in promiscuous mode. Maybe this is what was expected?

> I noticed that when I had it manually configured, whenever any sort of 
> routing was necessary, a neighbor solicitation was sent out, but never 
> made it to the other end. However, if I let it auto configure, it worked 
> fine, and as well if I added on the secondary addresss using "ifconfig 
> eth1 add ....", so, with that being said, is it a MAC or IP address 
> filtering problem?
> 
> Any ideas would be appreciated, I'd like to get this running, as I'm a 
> big fan of IPv6... I have 1 IPv4 address, but a whole /48 to work with. :-D
Addresses for free.

Thunder
-- 
Thunder from the hill.
Citizen of our universe.

