Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVBZFDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVBZFDz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 00:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVBZFDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 00:03:55 -0500
Received: from mail.tmr.com ([216.238.38.203]:39062 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262843AbVBZFDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 00:03:19 -0500
Message-ID: <42200337.30306@tmr.com>
Date: Sat, 26 Feb 2005 00:03:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>	 <421F9CE3.7010500@tmr.com> <1109368215.13193.4.camel@krustophenia.net>
In-Reply-To: <1109368215.13193.4.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-02-25 at 16:47 -0500, Bill Davidsen wrote:
> 
>>- sound: hasn't worked since FC1...
>>
> 
> 
> The ALSA lists have been deluged with reports like "sound worked in FC1,
> upgraded to FC3, no sound".   AFAICT it's just sloppiness on the part of
> the Fedora userspace tools.  For example, last I heard
> system-config-soundcard tries to load the emu10k1 module for cards that
> need the (completely different) emu10k1x driver.

The modules look good to me, they are the Intel modules which should 
would with ICH4-M.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
