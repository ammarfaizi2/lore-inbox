Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVCHBQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVCHBQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 20:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVCHBMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 20:12:42 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:28860 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261943AbVCHBKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 20:10:24 -0500
Message-ID: <422CFB6E.1020002@drzeus.cx>
Date: Tue, 08 Mar 2005 02:10:06 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Mark Canter <marcus@vfxcomputing.com>,
       rlrevell@joe-job.com, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com>	<20050303154929.1abd0a62.akpm@osdl.org>	<4227ADE7.3080100@drzeus.cx>	<4228D013.8010307@drzeus.cx>	<s5hmztfwon1.wl@alsa2.suse.de>	<422CB68A.1050900@drzeus.cx> <s5hekerurz8.wl@alsa2.suse.de>
In-Reply-To: <s5hekerurz8.wl@alsa2.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>>>Look at /etc/asound.state whether it contains the value of "Headphone
>>>Jack Sense" control true or false.
>>> 
>>>
>>>      
>>>
>>It saves the setting once I've been in 2.6.11. From an earlier kernel
>>there is no such entry.
>>    
>>
>
>Of course, the earlier version didn't have this.
>
>And did you take a look at the latest content?  What stands on it?
>Maybe you once saved a value wrongly corrected by any reason?
>
>  
>
I'm not sure what you mean. In the 2.6.10 version the last entry is 
'Stereo Mic'. In 2.6.11 there's 'Headphone Jack Sense' and 'Line Jack 
Sense' following that.
 From what I can tell every entry seems valid.

Rgds
Pierre

