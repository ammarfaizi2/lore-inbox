Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269532AbRHCSAo>; Fri, 3 Aug 2001 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCSAf>; Fri, 3 Aug 2001 14:00:35 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:20585 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269532AbRHCSAT>; Fri, 3 Aug 2001 14:00:19 -0400
Message-ID: <3B6AE67A.9060709@blue-labs.org>
Date: Fri, 03 Aug 2001 13:59:22 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108021728130.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it is that badly broken, isn't that sufficient criteria to justify 
the patch?

Yes, I have experienced this frustration many times myself.

David

Rik van Riel wrote:

>On Thu, 2 Aug 2001, Rik van Riel wrote:
>
>>On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
>>
>>>I'm about the zillionth person to complain about this problem on
>>>this list.  It is completely unacceptable to say that I can't
>>>use the memory on my machines because the kernel is too hungry
>>>for cache.
>>>
>>Fully agreed. The problem is that getting a solution which
>>works in a multizoned VM isn't all that easy, otherwise we
>>would have fixed it ages ago ...
>>
>
>Well, actually there are a few known solutions to this
>problem, but they are not really an option for the 2.4
>series since they require large code changes...
>


