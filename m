Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTAJTIC>; Fri, 10 Jan 2003 14:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbTAJTHE>; Fri, 10 Jan 2003 14:07:04 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:54552
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S266627AbTAJS4f>; Fri, 10 Jan 2003 13:56:35 -0500
Message-ID: <3E1F1963.500@rackable.com>
Date: Fri, 10 Jan 2003 11:05:07 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: John Jasen <jjasen@realityfailure.org>, Philip Dodd <smpcomputing@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
References: <3E1DFB8E.9050805@free.fr> <Pine.LNX.4.44.0301092139450.4282-100000@geisha.realityfailure.org> <20030110024710.GA19760@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2003 19:05:10.0188 (UTC) FILETIME=[3259A6C0:01C2B8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Thu, Jan 09, 2003 at 09:40:50PM -0500, John Jasen wrote:
>  
>
>>On Thu, 9 Jan 2003, Philip Dodd wrote:
>>
>>    
>>
>>>Jeff Garzik wrote:
>>>      
>>>
>>>>Anybody know where the source rpm for UnitedLinux kernel is?
>>>>[to be distinguished from kernel-source rpm]
>>>>        
>>>>
>>if they supply the kernel source rpm, how are they in violation? Since you 
>>can compile a kernel from the source rpm.
>>    
>>
>
>Read the GPL :)  The source code "preferred form" is clearly not an
>on-disk kernel tree with no information about the changes [patches]
>that were processed in a specific sequence, to produce that end result.
>
>  
>

  Actually the reverse could be much more easily said to be true.  If 
they only supplied the src.rpm,  and not the source rpm more people 
would scream than the reverse.   The number of people who know how to 
produce a custom kernel from a src.rpm is fairly limited.  Keep in mind 
most of UL's customer are not kernel hackers.


   Of course the correct thing to do is simply provide both and make 
people happy.  A determined person can still get what ever they want out 
of either form.  Making it hard just leads to your customers and the 
community hating you.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



