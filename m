Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRHTQpd>; Mon, 20 Aug 2001 12:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271398AbRHTQpY>; Mon, 20 Aug 2001 12:45:24 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:54890 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271393AbRHTQpS>; Mon, 20 Aug 2001 12:45:18 -0400
Message-ID: <3B813EA7.6050202@redhat.com>
Date: Mon, 20 Aug 2001 12:45:27 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stefan Fleiter <stefan.fleiter@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
In-Reply-To: <20010820105520.A22087@oisec.net> <E15YmR3-0005mb-00@the-village.bc.nu> <20010820144602.A12334@shuttle.mothership.home.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Fleiter wrote:
> Hi Alan!
> 
> On Mon, 20 Aug 2001 Alan Cox wrote:
> 
> 
>>>>With 2.4.8-ac7, I get SCSI errors and the kernel fails to boot. If I
>>>>compile with APIC enabled and APIC on UP also enabled, it boots
>>>>cleanly
>>>>
>>>I'm getting similair errors on 2.4.8-ac7 on my P2B-S motherboard using
>>>the NEW AIC7xxx driver, the old isn't experiencing these problems. Further
>>>i've been getting these errors since 2.4.3.
>>>
>>There is a known BIOS irq routing table problem with a large number of Intel
>>BIOS boards with onboard adaptec controllers.
>>
> 
> I have the same problem, but my Adaptec is _not_ onboard.

[snip]

This is *not* the same problem.  The original poster can't get his 
system booted at all (and that includes the fact that it won't even find 
all the drives and read partition tables or anything like that).  Your 
system is getting much further along.  Absolutely 0 progress is *vastly* 
different from progress mixed with some errors.



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

