Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVCDUp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVCDUp6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVCDUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:43:18 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23787 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263098AbVCDUg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:36:26 -0500
Message-ID: <4228C7CE.5010109@tmr.com>
Date: Fri, 04 Mar 2005 15:40:46 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Lee Revell <rlrevell@joe-job.com>
CC: Mark Canter <marcus@vfxcomputing.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
References: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com><4227085C.7060104@drzeus.cx> <1109875926.2908.26.camel@mindpipe>
In-Reply-To: <1109875926.2908.26.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
> 
>>The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
>>purpose?  The thought of having to disable the headphone jack and reenable 
>>it each time is trivial considering you can go with the fact that sound 
>>did not require the sound system touched under <= 2.6.10.
> 
> 
> You don't have to disable and re-enable it each time, if your system is
> configured correctly then your mixer settings will be saved.

I don't think you understand the problem. Saving the settings does help, 
you have to change the settings every time you switch from headphones to 
speaker. Assuming I follow the o.p. issue... alsamixer shows no "sense" 
settings for my ASUS laptop, and I have to boot 2.4 to get sound.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
