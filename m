Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292603AbSBPXLZ>; Sat, 16 Feb 2002 18:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292604AbSBPXLP>; Sat, 16 Feb 2002 18:11:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:31492 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292603AbSBPXLC>; Sat, 16 Feb 2002 18:11:02 -0500
Message-ID: <3C6EE6EB.9070506@evision-ventures.com>
Date: Sun, 17 Feb 2002 00:10:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] size-in-bytes
In-Reply-To: <UTC200202162245.WAA31932.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

>I planned a road to happiness in 92 steps, where each of the steps
>
Beware I may drive you to ruin if there will be less or more then 92 ;-)...

>does something clear and simple, simplifies the tree, beautifies
>the code, restructures in a clearly necessary way.
>Indeed, your suggested steps are also there.
>Five or six of these steps found their way into the kernel,
>(some thanks to Christoph Hellwig) but there is still a long way to go.
>The present patch is just a rediff of step 02.
>
My main concern is simple the following: The broken design was there for 
already 8 years and
the cleanup just goes far too slow for my personal taste if it goes at 
the same peace of speed as
of now...

>I do not know what the best strategy is, these times.
>I see you and Vojtech do good things to the IDE code,
>but would myself prefer to do such things in a series
>of really small steps. That way it is also very clear
>for Andre what happens.
>
Well I have no problems to synchronize in small steps. However I have
problems with synchronization in microsteps, becouse due to my daily 
dueties, which btw.
have *nothing* with kernel hacking to do, I can hardly go below the
resolution of a day.... Or more precisely: some time at afternoon which 
can vary
between:
- nothing
- a whole night
- a whole weekend

depending on:
- my personal mood,
- my druglevel,
- blood preassure,
- my world domination dreams (Andre thinks so apparently :-),
- the current conjugation between saturn and venus,

and so on...

But in fact: I'm flexible and even more happy if somebody, who can 
certainly devote more
time to it then me, just picks the shit^Wsuggestions I call patches up...

In regards of Andre, well unfortunately, after reading his last mail 
about my employer and
what-a-not, well I  have some... please  excuse me... concerns about his 
mind-wellth ;-)


