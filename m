Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262411AbSI2IEK>; Sun, 29 Sep 2002 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262412AbSI2IEK>; Sun, 29 Sep 2002 04:04:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262411AbSI2IEJ>;
	Sun, 29 Sep 2002 04:04:09 -0400
Message-ID: <3D96B511.1060308@pobox.com>
Date: Sun, 29 Sep 2002 04:08:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jbradford@dial.pipex.com
CC: Linus Torvalds <torvalds@transmeta.com>, jdickens@ameritech.net,
       mingo@elte.hu, kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com, andre@master.linux-ide.org
Subject: Re: v2.6 vs v3.0
References: <200209290716.g8T7GNwf000562@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pipex.com wrote:
>>The block IO cleanups are important, and that was the major thing _I_ 
>>personally wanted from the 2.5.x tree when it was opened. I agree with you 
>>there. But I don't think they are major-number-material.
> 
> 
> I'd definitely have voted for stable IPV6 being a 3.0.x requirement, but I guess it's a bit late now :-/

The USAGI guys have just started sending patches in, so there is already 
progress on this front.  And remember that stabilizing and bug fixing 
can continue after Oct 31st... that's just the feature freeze date.


>>Anyway, people who are having VM trouble with the current 2.5.x series, 
>>please _complain_, and tell what your workload is. Don't sit silent and 
>>make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
>>thing.
> 
> 
> I think the broken IDE in 2.5.x has meant that it got seriously less testing overall than previous development trees :-(.


I think this is true, but hopefully recent progress on all fronts will 
start encouraging testers to jump back in...   I have not seen any 
IDE-related corruption reports lately [but then maybe I missed them...]

BTW you should fix your word wrap :)

	Jeff



