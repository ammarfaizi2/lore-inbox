Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281957AbRK0Ryq>; Tue, 27 Nov 2001 12:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRK0Ryi>; Tue, 27 Nov 2001 12:54:38 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:41810 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S281957AbRK0Ry2>;
	Tue, 27 Nov 2001 12:54:28 -0500
Message-ID: <3C03D317.5080204@debian.org>
Date: Tue, 27 Nov 2001 18:53:27 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <fa.dac7a7v.1hkofg8@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2001 17:54:27.0170 (UTC) FILETIME=[8E5CBC20:01C1776C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dan Kegel wrote:

>>On Monday 26 November 2001 16:45, Mike Galbraith wrote:
>>
>>>>The only way we can get good testing for new kernels is to stop using
>>>>-preN prefix in development branch (2.5.x). Just increment that 'x'.
>>>>
>>>That won't change anything except the number on the kernel.  The people
>>>who you're trying to turn into bleeding edge testers (those who stay a
>>>little behind [bignum]) will continue to ride the curve at the point of
>>>their choosing.
>>>
>>Yes, but they can't tell which 2.5.x is more stable just from version number.
>>This way Linus will get better test coverage in 2.5.x.
>>
>>Those who need stability can read lkml and figure out which 2.5.x was 
>>'glitchless' :-) or stick with 2.4.x
>>
> 
> Agreed.  2.5.x should not use -pre.  Just increment X.  
> 


No. In the unstable branch there are frequent 'private' pre-release,
used for test or to syncronize big merges/changes.


Let continue actual status:

the normal release for everybody (restricted to developer) and the

pre reelase for special/merges patch.

	giacomo


