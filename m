Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSJECG6>; Fri, 4 Oct 2002 22:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJECG6>; Fri, 4 Oct 2002 22:06:58 -0400
Received: from postal2.lbl.gov ([131.243.248.26]:16791 "EHLO postal2.lbl.gov")
	by vger.kernel.org with ESMTP id <S261851AbSJECG5>;
	Fri, 4 Oct 2002 22:06:57 -0400
Message-ID: <3D9E47FD.9060205@slackers.net>
Date: Fri, 04 Oct 2002 19:01:33 -0700
From: "Matthew N. Andrews" <matt@slackers.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: "David S. Miller" <davem@redhat.com>, greearb@candelatech.com,
       linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
References: <Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>On Fri, 4 Oct 2002, David S. Miller wrote:
>
>  
>
>>   From: Ben Greear <greearb@candelatech.com>
>>   Date: Thu, 03 Oct 2002 21:19:37 -0700
>>
>>   Got my two new Netgear GA302t nics today.  They seem to use the
>>   tg3 driver....
>>   
>>   I put them into the 64/66 slots on my Tyan dual amd motherboard..
>>   Running kernel 2.4.20-pre8
>>   
>>You reported the other week problems with two Acenic's in
>>this same machine right?  The second Acenic wouldn't even probe
>>properly.  And the two Acenic's were identical.
>>
>>    
>>
>
>FWIW, my GA302T seems fine with the kernel he originally reported 
>(2.4.20-pre8).
>
>
>- James
>  
>
What version of the bios does your motherboard have? I had problems with 
a dual syskonnect board on this motherboard(tyan 2466) where it would 
not would not initialize properly under the older bios.

-Matt


