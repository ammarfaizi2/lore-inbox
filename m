Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVEXPs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVEXPs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVEXPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:47:28 -0400
Received: from mail3.utc.com ([192.249.46.192]:461 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262117AbVEXPmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:42:44 -0400
Message-ID: <42934B3E.10106@cybsft.com>
Date: Tue, 24 May 2005 10:41:50 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <42930E79.1030305@cybsft.com> <42934674.30406@yahoo.com.au>
In-Reply-To: <42934674.30406@yahoo.com.au>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> K.R. Foley wrote:
> 
>>
>> There are definitely those who would prefer to have the functionality,
>> at least as an option, in the mainline kernel. The group that I contract
>> for get heartburn about having to patch every kernel running on every
>> development workstation and every production system. We need hard RT,
>> but currently when we have to have hard RT we go with a different
>> product.
> 
> 
> Well, yes. There are lots of things Linux isn't suited for.
> There are likewise a lot of patches that SGI would love to
> get into the kernel so it runs better on their 500+ CPU
> systems. My point was just that a new functionality/feature
> doesn't by itself justify being included in the kernel.org
> kernel.

Agreed. Maybe the Linux kernel can't be all things to all of us, even as 
configuration options. I am certainly not the one who is going to make 
that decision either. I just wanted voice my opinion from a 
user/developer perspective.

> 
>> Another thing that some of us want/need is a hard real-time
>> Linux that doesn't create the segregation that most of these specialized
>> products create. Currently there are damn few choices for real posix
>> applications development with hard RT requirements running in a Unix
>> environment.
>>
> 
> Maybe there are damn few because it is hard to get right within
> the framework of a general posix environment. Or maybe its
> because it has a comparatively small userbase (compared to say
> mid/small servers and desktops). Which are neither completely
> invalid reasons against its inclusion in Linux.
> 
> But I want to be clear that I haven't read or thought about the
> code in question too much, and I don't have any opinions on it
> yet. So please nobody involve me in a flamewar about it :)
> 
> Nick
> 
> 

And please don't misunderstand my statements as trying start a flamewar 
either. :-)

-- 
    kr
