Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUATNSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUATNSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:18:38 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:19640 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S265479AbUATNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:18:36 -0500
Message-ID: <400D2AB2.7030400@borgerding.net>
Date: Tue, 20 Jan 2004 08:18:42 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
References: <1074532714.16759.4.camel@midux> <microsoft-free.87vfn7bzi1.fsf@eicq.dnsalias.org> <1074536486.5955.412.camel@castle.bigfiber.net> <200401201046.24172.hus@design-d.de>
In-Reply-To: <200401201046.24172.hus@design-d.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me too.  I cannot get ALSA working on my SB Live.

If I may be so bold as to make a suggestion: Maybe the developer in
charge of ALSA's e-mu driver could work with us poor unfortunates.
There may be some commonality between our systems that causes this
(besides the sound blaster live).

My system:
Sound: SBLive Value
Redhat 7.3 (w/ piecemeal recompiles & upgrades)
Kernel: 2.6.1
CPU: Athlon XP 2100+
Mobo: ASUS (I think it's A7V333. I can confirm this later.)


-- Mark "runnin' dirty and deprecated" Borgerding



Heinz Ulrich Stille wrote:

>On Monday 19 January 2004 19:21, Travis Morgan wrote:
>  
>
>>I have a soundblaster Live Value card. I can no longer control the
>>    
>>
>
>I also have a SB Live!, and it doesn't work with ALSA at all - the AC97
>codec doesn't load. I haven't taken the time to track it down as it does
>work just fine with OSS (under SMP at that).
>
>  
>
>>output level through my digital out. With OSS my PCM volume used to
>>affect both the headphone jack and the digital out. With ALSA it affects
>>only the headphone jack.
>>    
>>
>
>That's a purely firmware thing with this card; you should just have to
>load the right patches. I don't know whether there is a loader utility
>for alsa, though. Perhaps the old utils will work?
>
>Anyway, even if it's not working for me at the moment, it's still the
>superior architecture; just wait until the bugs affecting your specific
>situation are ironed out and userland utilities are available...
>
>MfG, Ulrich
>
>  
>



