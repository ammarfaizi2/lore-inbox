Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQLNCas>; Wed, 13 Dec 2000 21:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbQLNCai>; Wed, 13 Dec 2000 21:30:38 -0500
Received: from user-137-122.jakinternet.co.uk ([212.187.137.122]:9824 "EHLO
	linux.home") by vger.kernel.org with ESMTP id <S130753AbQLNCaS>;
	Wed, 13 Dec 2000 21:30:18 -0500
Date: Thu, 14 Dec 2000 02:03:14 GMT
From: James Stevenson <mistral@stev.org>
Message-Id: <200012140203.CAA16009@linux.home>
To: mhaque@haque.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12: eth0 trasmit timed out after one hour uptime
In-Reply-To: <3A380563.72619BD@haque.net>
In-Reply-To: <3A37FFC9.19F05305@cheek.com> <3A380238.CA7BB0B2@haque.net> <3A3802AA.1FD36245@cheek.com> <3A380563.72619BD@haque.net>
Reply-To: mistral@stev.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i may have also had some problems with this
when i was connected to the net though ppp (most of the night)
so far in about 6 hours it has stoped transmitting 2 times but still
recives it is fine after i disconnect and reconnect i will try and get it
to stop working with heavry disk io
BTW this is all under 2.2.18 and never had any problem with the isp
over the past month or so.


In local.linux-kernel-list, you wrote:
>At first I thought my lockups were HD i/o related also but then the last
>lockup I had happened a while after I trashed my disk but while grabbing
>email (ppp link).
>
>Joseph Cheek wrote:
>> 
>> 00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
>> (rev 30)
>> 
>> i've been doing a ton of compiling which has thrashed the [IDE] HD,
>> perhaps it is related.  other than that, just normal web surfing...
>
>-- 
>
>


-- 
---------------------------------------------
Check Out: http://stev.org
E-Mail: mistral@stev.org
  1:50am  up 1 day, 11:05,  7 users,  load average: 0.11, 0.09, 0.03
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
