Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281760AbRKZPTM>; Mon, 26 Nov 2001 10:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRKZPTC>; Mon, 26 Nov 2001 10:19:02 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26383 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S281760AbRKZPSp>; Mon, 26 Nov 2001 10:18:45 -0500
Date: Mon, 26 Nov 2001 10:18:45 -0500
Message-Id: <200111261518.fAQFIj201541@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.15-pre9
X-Newsgroups: linux.kernel
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com>
In-Reply-To: <20011122134700.A4966@bee.lk>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com> 
  torvalds@transmeta.com claimed this objective:
>
>On Thu, 22 Nov 2001, Anuradha Ratnaweera wrote:
>>
>> On Wed, Nov 21, 2001 at 10:44:30PM -0800, Linus Torvalds wrote:
>> >
>> > I think I'm ready to hand this over to Marcelo.
>>
>> Aren't you going to include Tim Schmielau's patch to handle uptime larger than
>> 497 days?  It is a cool feature we always liked to have.
>
>Quite frankly, right now I'm in "handle only bugs that can crash the
>system mode". Anything that takes 497 days to see is fairly low on my
>priority list. My highest priority, in fact, is to get 2.4.15 out without
>any embarrassment.

Back in the 60's when GE was still a mainframe manufacturer they had a
counter which rolled over at about 35 days. When it started failing
their competitors had good time with "GECOS fails to fail as expected."
That *is* an embarrassment.

con06:news> uptime
  9:56am  up 427 days, 19:00,  2 users,  load average: 0.87, 0.88, 0.83

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
