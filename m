Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289074AbSANV3W>; Mon, 14 Jan 2002 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289072AbSANV3N>; Mon, 14 Jan 2002 16:29:13 -0500
Received: from freeside.toyota.com ([63.87.74.7]:4880 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S289067AbSANV3D>; Mon, 14 Jan 2002 16:29:03 -0500
Message-ID: <3C434D95.3060106@lexus.com>
Date: Mon, 14 Jan 2002 13:28:53 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16QB7T-0002JS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>stays on.  That's another problem, and I did play with some patches this
>>>weekend without making myself really happy :-( Another topic,
>>>unfortunately.
>>>
>>Patience, the problem is understood and there will be a fix in the 2.5 
>>timeframe.
>>
>
>Without a fix in the 2.4 timeframe everyone has to run 2.2. That strikes
>me as decidedly non optimal. If you are having VM problems try both the
>Andrea -aa and the Rik rmap-11b patches (*not together*) and report back
>
Easiest is to grab 2.4.17 and apply 2.4.18pre2 and 2.4.18pre2-aa2 -

pre2-aa2 has all the fixes and tweaks I had been doing by hand.

cu

jjs

>


