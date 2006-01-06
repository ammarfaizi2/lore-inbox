Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWAFAOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWAFAOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbWAFAOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:14:46 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:13245 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1750887AbWAFAOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:14:44 -0500
In-Reply-To: <1136504460.847.91.camel@mindpipe>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <s5hmziaird8.wl%tiwai@suse.de> <Pine.LNX.4.61.0601060028310.27932@zeus.compusonic.fi> <1136504460.847.91.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A284096-E889-4E6D-B017-B8241CD72A0D@dalecki.de>
Cc: Hannu Savolainen <hannu@opensound.com>, Takashi Iwai <tiwai@suse.de>,
       linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [OT] ALSA userspace API complexity
Date: Fri, 6 Jan 2006 01:14:28 +0100
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-06, at 00:40, Lee Revell wrote:

> On Fri, 2006-01-06 at 01:06 +0200, Hannu Savolainen wrote:
>> We have not received any single bug report that is caused
>> by the concept of kernel mixing.
>> Kernel mixing is not rocket science. All you need to do is picking a
>> sample from the output buffers of each of the applications, sum them
>> together (with some volume scaling) and feed the result to the
>> physical
>> device.
>
> Hey, interesting, this is exactly what dmix does in userspace.  And we
> have not seen any bug reports caused by the concept of userspace  
> mixing
> (just implementation bugs like any piece of software).

This attitude that every kind of software has to have bugs is
blunt idiotic tale-tale bullshit just showing off complete incompetence.

Does the acronym car-ABS and micro-controller maybe perhaps ring a  
bell for you? 
