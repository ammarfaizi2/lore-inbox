Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281566AbRLALWJ>; Sat, 1 Dec 2001 06:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281562AbRLALV6>; Sat, 1 Dec 2001 06:21:58 -0500
Received: from fever.semiotek.com ([216.138.209.203]:23567 "HELO
	fever.semiotek.com") by vger.kernel.org with SMTP
	id <S281561AbRLALVo>; Sat, 1 Dec 2001 06:21:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re:  Re: Please tag tested releases of the 2.4.x kernel
Message-Id: <20011201113734.5187E38329@fever.semiotek.com>
Date: Sat,  1 Dec 2001 06:37:34 -0500 (EST)
From: jread@semiotek.com (Justin Wells)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@ns.caldera.de> wrote:

>In article <20011130220451.9D5AD38326@fever.semiotek.com> you wrote:
>>
>> It would be great if on kernel.org there were a note indicating which 
>> releases of the linux kernel had been favourably received. 
>>
>> If you could organize a bit you could even mark a release as "TESTED",
>> or even "APPROVED". All it would mean is that after it had been out for
>> a week or two nobody found any really serious problems.

>Approved kernel are usually come in files ending in i386.rpm,
>ia64.rpm or .deb.

>Come on, no one expects stock kernel to be tested.  Distributors
>on the other hand spend a lot of effort on testing their releases,
>so go for a distribution kernel if you need something tested.  Really.

I'm sure I'm not the only one who would like to know which stock kernels 
are relatively stable, and which ones aren't. There must be at least two
more people, just like me, who wonder which stock kernel to use.

Just because I like to apply a few patches that my distributor doesn't 
ship doesn't mean that I want to play russian roulette with my system,
though I'm willing to risk the occasional bug or problem when
I compile my own kernel.

And the kernels on kernel.org *are* tested, by lots of people, by kernel 
developers, by lots of ordinary folks even. I bet right after theren's 
an announce on slashdot you see lots of traffic on the ftp/http sites.

After a week or two I bet you even have some pretty good idea which
stock kernels are relatively stable, and which ones have big issues.

The word "relatively" is important here, everyone knows that if you roll 
your own kernel you're facing some risks. But everyone also knows that 
for some of the stock kernels the risks are reasonable, and for some of
them the risks are unreasonable.

I'm not asking for any additional testing, I'm just asking someone to 
summarize the consensus about a kernel once it's been kicked around 
for a week or two.

Justin

