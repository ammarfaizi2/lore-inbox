Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280655AbRKFWrI>; Tue, 6 Nov 2001 17:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280641AbRKFWq6>; Tue, 6 Nov 2001 17:46:58 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:42398 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S280653AbRKFWqt>;
	Tue, 6 Nov 2001 17:46:49 -0500
Message-ID: <3BE86853.9020305@candelatech.com>
Date: Tue, 06 Nov 2001 15:46:43 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl> <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva> <20011106152826.C31923@codepoet.org> <20011106233349.A26236@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan-Benedict Glaw wrote:

> On Tue, 2001-11-06 15:28:26 -0700, Erik Andersen <andersen@codepoet.org>
> wrote in message <20011106152826.C31923@codepoet.org>:
> 
>>On Tue Nov 06, 2001 at 07:24:13PM -0200, Rik van Riel wrote:
>>
>>>PROCESSOR=0
>>>VENDOR_ID=GenuineIntel
>>>CPU_FAMILY=6
>>>MODEL=6
>>>MODEL_NAME="Celeron (Mendocino)"
>>>.....
>>>
> 
> PROCESSOR=1


or PROCESSOR1=1

Either way, it's still trivial to parse with perl or c/c++/Java
and probably a dozen other languages I don't know...

Ben


> ...
> 
> 
>>>. /proc/cpuinfo
>>>
>>I think we have a winner!  If we could establish this 
>>as policy that would be _sweet_!
>>
> 
> What do you expect on a SMP system?
> 
> MfG, JBG
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


