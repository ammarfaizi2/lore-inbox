Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUBECzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUBECzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:55:55 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:8870 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264313AbUBECzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:55:52 -0500
Message-ID: <4021AF52.1080009@cyberone.com.au>
Date: Thu, 05 Feb 2004 13:49:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040202194626.191cbb95.akpm@osdl.org>	<87llnk2js9.fsf@codematters.co.uk>	<20040203132913.6145f4e6.akpm@osdl.org>	<87znbzg78o.fsf@codematters.co.uk> <402087B3.1080302@cyberone.com.au>	<877jz291jm.fsf@codematters.co.uk> <87y8riifey.fsf@codematters.co.uk>
In-Reply-To: <87y8riifey.fsf@codematters.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Philip Martin wrote:

>Philip Martin <philip@codematters.co.uk> writes:
>
>
>>Nick Piggin <piggin@cyberone.com.au> writes:
>>
>>
>>>What are you building, by the way? It slipped my mind.
>>>
>>All the 2.6 figures so far are for a plain 2.6.1.  I've just switched
>>to 2.6.2 and at first glance it's the same as 2.6.1.
>>
>

Sorry, I mean what is it that you are timing?

>This is the profile for 2.6.2, it is very much like 2.6.1
>
>248.07user 118.81system 3:42.00elapsed 165%CPU (0avgtext+0avgdata 0maxresident)k
>0inputs+0outputs (434major+3770493minor)pagefaults 0swaps
>
>

If you get time, could you test the patch I sent you?

