Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUCANWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUCANWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:22:42 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:18368 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261258AbUCANWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:22:40 -0500
Date: Mon, 01 Mar 2004 21:22:19 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Martin Wickman" <martin.wickman@xms.se>,
       "Karol Kozimor" <sziwan@hell.org.pl>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Micha Feigin" <michf@post.tau.ac.il>,
       "Software suspend" <swsusp-devel@lists.sourceforge.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston> <20040301113528.GA21778@hell.org.pl> <1078140515.21578.76.camel@gaston> <20040301115135.GA2774@hell.org.pl> <40433303.1020506@xms.se>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr36p3hq14evsfm@smtp.pacific.net.th>
In-Reply-To: <40433303.1020506@xms.se>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 13:56:35 +0100, Martin Wickman <martin.wickman@xms.se> wrote:

> Karol Kozimor wrote:
>> Thus wrote Benjamin Herrenschmidt:
>> Right, but the point is that while 2.6 has such an infrastructure, its
>> introduction actually completely broke UHCI suspend / resume.
>>
>>>> There's also a great deal of people, who can't resume when AGP is being
>>>> used -- that is again a regression over 2.4.
>>>
>>> There haven't been a regression in the AGP drivers themselves afaik.
>>
>> Which, again, leads us to conclusion that it was the driver model change
>> that broke that.
>>
>> I'm not trying to criticize the driver model itself (I'm sure others have
>> already done enough), but merely to emphasize that 2.6 is not yet ready for
>> laptop users.
>
> ...and it's pretty obvious that it'll never be unless it's
> fixed. Its kinda frustrating this agp resume thing keeps holding swsusp2
> back -- everything else works (on my laptop at least).
> -

PM and driver issues are holding back many non-server applications moving
 from 2.4 to 2.6, and to a substantial extend prevent people moving away
 from XP...

Regards
Michael

