Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWGECcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWGECcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGECcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:32:06 -0400
Received: from mail.tmr.com ([64.65.253.246]:3241 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932355AbWGECcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:32:05 -0400
Message-ID: <44AB2685.1000409@tmr.com>
Date: Tue, 04 Jul 2006 22:40:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>            <44A9A196.1010602@tmr.com> <200607041501.k64F1qur024266@turing-police.cc.vt.edu>
In-Reply-To: <200607041501.k64F1qur024266@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Mon, 03 Jul 2006 19:00:38 EDT, Bill Davidsen said:
>  
>
>>Valdis.Kletnieks@vt.edu wrote:
>>    
>>
>
>  
>
>>>There's other issues as well.  Why do people run 'tripwire' on boxes that
>>>have RAID on them?
>>>      
>>>
>>What has RAID got to do with detecting hacking?
>>    
>>
>
>Actually, I've had tripwire detect more *accidental* changes due to buggy
>software than I have had it detect actual hacking.  Oh, and it's good at
>catching unintended config changes - I started using tripwire after I
>fat-fingered a script, and the machine backed up to /dev/null instead of
>/dev/rmt0.
>  
>
But it ran faster, right? ;-)

>In fact, I've never actually had tripwire detect actual hacking.
>  
>
I was using hacking in the general sense, I have a spiffy quote around 
about being in more danger from incompetence than malice. Patches with 
side effects, changes which work but reset directory permissions and/or 
ownership... I think it was Pogo who said "we have met the enemy and he 
is us."

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

