Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284911AbRLFA4S>; Wed, 5 Dec 2001 19:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284912AbRLFA4J>; Wed, 5 Dec 2001 19:56:09 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:20971 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284911AbRLFAzz>; Wed, 5 Dec 2001 19:55:55 -0500
Message-ID: <3C0EC219.8010107@redhat.com>
Date: Wed, 05 Dec 2001 19:55:53 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0EB1F2.7050007@optonline.net> <3C0EB46C.4010806@optonline.net> <3C0EBAEF.5090402@redhat.com> <3C0EC0ED.3000603@optonl!
 ine.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> Doug Ledford wrote:
> 
>> Nathan Bryant wrote:
>>
>> OK, on my site there is now a 0.10 version of the driver.  This one 
>> stands a reasonable chance of working in mmap mode.  Please give it a 
>> try and let me know what happens (see my comments in 
>> __i810_update_lvi() to see what I think the actual problem is).
>>
>> http://people.redhat.com/dledford/i810_audio.c.gz
>>
>>
>>
>>
> some fixes needed, attached


Thanks, applied.  (I haven't been compile testing these patches because 
I would have to set up another compile environment just to get it to 
work, my current ones won't work for it)





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

