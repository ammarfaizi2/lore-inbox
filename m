Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSKOTKB>; Fri, 15 Nov 2002 14:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266553AbSKOTKA>; Fri, 15 Nov 2002 14:10:00 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:58377
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S266548AbSKOTJ6>; Fri, 15 Nov 2002 14:09:58 -0500
Message-ID: <3DD546B9.3040000@rackable.com>
Date: Fri, 15 Nov 2002 11:10:49 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Chilton <ian@ichilton.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Anyone use HPT366 + UDMA in Linux?
References: <20021115123541.GA1889@buzz.ichilton.co.uk> <1037371184.19971.0.camel@irongate.swansea.linux.org.uk> <20021115184202.GB32543@buzz.ichilton.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 19:16:45.0159 (UTC) FILETIME=[8973CF70:01C28CDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Chilton wrote:

>Hello,
>
>  
>
>>If it still doesnt work in 2.4.20-rc1-ac2 or later please send me a
>>detailed bug report
>>    
>>
>
>Does that mean you know it's been broken and/or are there changes to
>HPT366 in 2.4.20-rc1-ac2?
>  
>
  What is means is Alan is doing a thankless job fixing the current ide 
mess.  The ac 2.4/2.5 trees are being used to test a number of updates. 
 If you can provide Alan good bug report on the issue in 2.4.20-rc1-ac2. 
 He will take a look at fixing the code.  I think the info he needs 
would be:
-The ide section of dmesg or all of dmesg
-output of hdparm -vi /dev/hd(whatever)
-result of hdparm -d 1 /dev/hd(whatever)


>I've been trying 2.4.19, 2.4.20-pre11 and 2.4.20-rc1 with and without
>Rik's fairsched patch.
>
>
>  
>



