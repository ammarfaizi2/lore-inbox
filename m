Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbUJZERu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbUJZERu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUJZERb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:17:31 -0400
Received: from relay03.pair.com ([209.68.5.17]:20229 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262163AbUJZEPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:15:35 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417DCF66.9030006@cybsft.com>
Date: Mon, 25 Oct 2004 23:15:34 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>	 <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com>	 <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu>	 <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu>	 <20041025160330.394e9071@mango.fruits.de> <20041025141008.GA13512@elte.hu>	 <20041025141628.GA14282@elte.hu>	 <33313.192.168.1.5.1098733224.squirrel@192.168.1.5>	 <1098759671.9166.10.camel@krustophenia.net>  <417DC046.1020806@cybsft.com> <1098763092.9166.17.camel@krustophenia.net>
In-Reply-To: <1098763092.9166.17.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2004-10-25 at 22:11 -0500, K.R. Foley wrote:
> 
>> 
>>Not being familiar with jack, does it use rtc?
>>
> 
> 
> No it normally uses the soundcard for timing.  For testing there is a
> dummy backend that just usleep()s.  This makes a pretty useful latency
> tester.
> 
> Lee
> 
> 
Just wondered. I am writing an email right now about my results with
V0.2, one of which happens to be that amlat will kill any of my systems
running it.

kr

