Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262159AbVAOC2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbVAOC2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVAOC2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:28:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:1005 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262153AbVAOC2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:28:23 -0500
Message-ID: <41E87DC8.7030401@osdl.org>
Date: Fri, 14 Jan 2005 18:19:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jack O'Quin" <joq@io.com>
CC: Lee Revell <rlrevell@joe-job.com>, Matt Mackall <mpm@selenic.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <20050110212019.GG2995@waste.org>	<200501111305.j0BD58U2000483@localhost.localdomain>	<20050111191701.GT2940@waste.org>	<20050111125008.K10567@build.pdx.osdl.net>	<20050111205809.GB21308@elte.hu>	<20050111131400.L10567@build.pdx.osdl.net>	<20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>	<20050113063446.GV2940@waste.org> <87is61b0l4.fsf@sulphur.joq.us>	<1105735965.7258.24.camel@krustophenia.net> <87zmzb7cb3.fsf@sulphur.joq.us>
In-Reply-To: <87zmzb7cb3.fsf@sulphur.joq.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
>>On Thu, 2005-01-13 at 13:17 -0600, Jack O'Quin wrote:
>>
>>>But there may be other, better solutions to the deadlock problem.
>>>Several years ago, Roger Larsson wrote a completely user-space
>>>realtime monitor program that works perfectly well for revoking
>>>realtime privileges when it detects CPU starvation.  I still use it
>>>occasionally to help debug problems if the built-in JACK watchdog
>>>timer doesn't catch them.
> 
> 
> Lee Revell <rlrevell@joe-job.com> writes:
> 
>>Do you have a link to Roger Larsson's RT watchdog?
> 
> 
> No official, supported version.  With his permission, I posted a copy
> on my home system a year ago for some audio users who had inquired
> about it.  That copy is here...
> 
>   http://www.joq.us/joq/rt_monitor.tgz

Bad URL, not found....

-- 
~Randy
