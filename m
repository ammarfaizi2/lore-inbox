Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263560AbTCUJUw>; Fri, 21 Mar 2003 04:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbTCUJUw>; Fri, 21 Mar 2003 04:20:52 -0500
Received: from navigator.sw.com.sg ([213.247.162.11]:57014 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP
	id <S263560AbTCUJUv>; Fri, 21 Mar 2003 04:20:51 -0500
From: Vladimir Serov <vserov@infratel.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3E7ADBFD.4060202@infratel.com>
Date: Fri, 21 Mar 2003 12:31:41 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>	<3E79EAA8.4000907@infratel.com> <15993.60520.439204.267818@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>>>>>>" " == Vladimir Serov <vserov@infratel.com> writes:
>>>>>>            
>>>>>>
>
>     > interrupt handler for NIC, it's gone !!!  IMHO this is due to
>     > the race in the nfs client.
>
>Why would an NFS race show up only on PPC? Do you have a tcpdump?
>  
>
Hi , Trond
As I wrote , another persone has similar problems on PC's,  as to me it 
was a big suprise to see such a problem in nfs, cause i'm using it for 
over 10 yers in a different setups's OS's , etc. Yes I have tcpdump , 
and as i wrote, nothing wrong is going on with packet receiption,  where 
is now corrupted packets , no error messages, NOTHING !!!! Just RPC 
request gets lost, I mean not correctly connected to the some queue or 
caller. It last for over a year ,  and is a big pain in the ass of 
company i'm working for now.

With best regards, Vladimir.
