Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTI1R4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTI1R4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 13:56:06 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:65162 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S262665AbTI1R4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:56:03 -0400
Message-ID: <3F772108.9090301@softhome.net>
Date: Sun, 28 Sep 2003 19:57:28 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
CC: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch> <3F76DCEC.60508@softhome.net> <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz> <3F771893.1020405@softhome.net> <Pine.LNX.4.58.0309281329480.14330@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.58.0309281329480.14330@filesrv1.baby-dragons.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. James W. Laferriere wrote:
>>>Yes, it should. If you have 0.25GB, it can be copied into cache. If you
>>>have 0.125GB, it doesn't fit there.
>>
>>   So you want to say to effectively copy (or whatever) 40GB harddrive I
>>have to have 40GB of RAM? Ridiculous.
>>   Especially if copying is done in 4k lumps. (cp's default buffer)
>><sarcasm flavour=sad> Hopefully not everyone shares your opinion. </sarcasm>
> 
> 	If I am correct ,  I beleive he is speaking of the amount of
> 	MEMORY needed to cache the copy of file data WITHOUT a swap
> 	partit. or file .

   Probably I have misunderstood.
   Can you once again explain it to me - slowly.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

