Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbTAITGy>; Thu, 9 Jan 2003 14:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTAITGy>; Thu, 9 Jan 2003 14:06:54 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:5971 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S266957AbTAITGy>;
	Thu, 9 Jan 2003 14:06:54 -0500
Message-ID: <3E1DCA8D.4040005@acm.org>
Date: Thu, 09 Jan 2003 13:16:29 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
References: <200301090332.h093WML05981@hera.kernel.org>	 <20030109164407.GA26195@codemonkey.org.uk>	 <1042135594.27796.37.camel@irongate.swansea.linux.org.uk>	 <20030109172229.GA27288@codemonkey.org.uk> <1042135971.27796.44.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Thu, 2003-01-09 at 17:22, Dave Jones wrote:
>  
>
>>On Thu, Jan 09, 2003 at 06:06:34PM +0000, Alan Cox wrote:
>>
>> > Arghhh I was told Linus accepted it, and my tree indexer found "IPMI" so
>> > decided it was present too. (Only the i2c definitions apparently).
>>
>>Shouldn't cause any problems in 2.4 anyways should it ?
>>After all, its 'just another driver'.
>>
>> > Oh well, it should be in 2.5
>>
>>Added to the queue of bits from the 2.4 changesets list that I'm
>>intending to push to Linus soon.
>>    
>>
>
>Pull the 2.5 port from openipmi.sourceforge.net  saves you doing the port
>yourself. 
>
Definately pull the 2.5 port from there, as there are some differences 
between the 2.4 and 2.5 versions.

-Corey


