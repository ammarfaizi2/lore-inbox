Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSLFOUR>; Fri, 6 Dec 2002 09:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSLFOUR>; Fri, 6 Dec 2002 09:20:17 -0500
Received: from lucidpixels.com ([66.45.37.187]:1413 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S262859AbSLFOUP>;
	Fri, 6 Dec 2002 09:20:15 -0500
Message-ID: <3DF0B3E2.8060104@lucidpixels.com>
Date: Fri, 06 Dec 2002 09:27:46 -0500
From: jpiszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
CC: netfilter-devel@lists.netfilter.org,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Question with printk warnings in ip_conntrack with 2.4.20.]
References: <Pine.LNX.4.33.0212061448500.2648-100000@blackhole.kfki.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure:

http://installkernel.tripod.com/tcpdump.log.bz2

Jozsef Kadlecsik wrote:

>On Thu, 5 Dec 2002, jpiszcz wrote:
>
>  
>
>>Stange?  I am just using vcheck (perl script) that goes out and checks
>>out software for the latest versions.
>>    
>>
>
>If the script uses active mode FTP and when that is refused by the server
>reverts back to passive mode, that is a natural explanation for such log
>entries.
>
>Could you record by tcpdump at least one such FTP session?
>
>  
>
>>Will there possibly be a /proc or kernel config option for warnings such
>>as these?
>>    
>>
>
>In my opinion a new directory tree /proc/sys/net/ipv4/netfilter is
>required so that tuning options could be easily added to the system.
>But that implies backward (in)compatibily issues...
>
>Regards,
>Jozsef
>-
>E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
>PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
>Address : KFKI Research Institute for Particle and Nuclear Physics
>          H-1525 Budapest 114, POB. 49, Hungary
>
>
>
>  
>


