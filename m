Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272459AbTGZLJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 07:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272460AbTGZLJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 07:09:08 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:18371 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S272459AbTGZLJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 07:09:05 -0400
Message-ID: <3F2264DF.7060306@wmich.edu>
Date: Sat, 26 Jul 2003 07:24:15 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Teo <eugene.teo@eugeneteo.net>
CC: LKML <linux-kernel@vger.kernel.org>, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <3F2251D3.3090107@sambara.org> <20030726101015.GA3922@eugeneteo.net>
In-Reply-To: <20030726101015.GA3922@eugeneteo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd really wish people would use examples other than a single player to 
generalize the performance of the kernel. For all you know xmms's 
decoder for the type of music you listen to could be written unoptimally 
to put it as nice as possible.  If all players and different types of 
pcm audio decoders are skipping in the situations you experience then 
that's different, but i hardly think that will be the case as it is not 
with me nor, ever has been that i can remember (maybe in early 2.3.x).


Eugene Teo wrote:
> What I really want to see is the best of both worlds if possible.
> Well, some may be more keen to see responsiveness in work-related
> tasks, there are others who wants more responsiveness in their
> leisure-related work. I hope that Con do not stop developing his 
> interactive improvements just because mingo is starting to work 
> his too.
> 
> Eugene
> 
> <quote sender="Ismael Valladolid Torres">
> 
>>Marc-Christian Petersen escribe el 26/07/03 11:46:
>>
>>>XMMS does not skip, but hey, I don't care about XMMS skipping at all.
>>
>>For those of us who'd like to use Linux as a serious musical production 
>>environment in the near future, it is important to have the choice of a 
>>system that does exactly that. This is, audio should not skip even on a 
>>heavily loaded system. We do not care much about graphical 
>>responsiveness. Think of something like Pro Tools LE running over Mac 
>>OS, with up to 32 audio tracks being mixed without the help of a DSP 
>>chip. Even when CPU usage gets higher than 80%, you don't get a single 
>>audio glitch.
>>
>>Of course, for musical production, also the lowest latency achievable is 
>>a must.
>>
>>This is only a humble opinion which I hope you find useful.
>>
>>Regards, Ismael
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


