Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268088AbUJHGun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268088AbUJHGun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 02:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUJHGun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 02:50:43 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:8654 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268088AbUJHGuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 02:50:14 -0400
Message-ID: <4166386F.7050504@kolivas.org>
Date: Fri, 08 Oct 2004 16:49:19 +1000
From: Con Kolivas <lkml@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>	 <20041007105230.GA17411@elte.hu>	 <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>	 <32798.192.168.1.5.1097191570.squirrel@192.168.1.5> <1097213813.1442.2.camel@krustophenia.net>
In-Reply-To: <1097213813.1442.2.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2004-10-07 at 19:26, Rui Nuno Capela wrote:
> 
>>Ingo Molnar wrote:
>>
>>>>i've released the -T3 VP patch:
>>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
>>>>
>>>
>>OK. Just to let you know, both of my personal machines are now running on
>>bleeding-edge 2.6.9-rc3-mm3-T3, and very happily may I assure :)
> 
> 
> This actually feels a _lot_ snappier than mm2, which seemed prone to
> weird stalls.  I don't have any numbers to back this up yet.

mm2 had a completely different cpu scheduler so no meaningful comparison 
can be made. Try comparing to mm3 vanilla.

Cheers,
Con
