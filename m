Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbVCDUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVCDUlq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCDUdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:33:36 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21483 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S263116AbVCDUbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:31:46 -0500
Message-ID: <4228C6D9.8010701@tmr.com>
Date: Fri, 04 Mar 2005 15:36:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nish Aravamudan <nish.aravamudan@gmail.com>
CC: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net
Subject: Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx><4227085C.7060104@drzeus.cx> <29495f1d05030309455a990c5b@mail.gmail.com>
In-Reply-To: <29495f1d05030309455a990c5b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nish Aravamudan wrote:
> On Thu, 03 Mar 2005 13:51:40 +0100, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> 
>>I just upgraded to Linux 2.6.11 and the soundcard on my machine went
>>silent. All volume controls are correct and there are no errors
>>reported. But no sound coming from the speakers. And here's the kicker,
>>the headphones work fine!
>>2.6.10 still works so the bug appeared in one of the patches in between.
>>The sound card is the one integrated into intels mobile ICH4 chipset.
> 
> 
> There was some discussion of this on LKML a while ago. Are you sure
> you have disabled "Headphone Jack Sense" and "Line Jack Sense" in
> alsamixer?

Is there some option to alsamixer to get those to show up? There's no 
such entry in the default display (FC3 w/ kernel.org 2.6.1[01]).

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
