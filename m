Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUHXVet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUHXVet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268332AbUHXVet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:34:49 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:21604 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S268347AbUHXVad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:30:33 -0400
Message-ID: <412BB372.9000009@travellingkiwi.com>
Date: Tue, 24 Aug 2004 22:30:26 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jonathan Bastien-Filiatrault <joe@dastyle.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Wakko Warner <wakko@animx.eu.org>,
       "David N. Welton" <davidw@dedasys.com>,
       Lee Revell <rlrevell@joe-job.com>,
       James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Linux Incompatibility List
References: <87r7q0th2n.fsf@dedasys.com> <20040821201632.GA7622@digitasaru.net> <20040821202058.GA9218@animx.eu.org> <1093120274.854.145.camel@krustophenia.net> <41282F4C.9060305@dastyle.net> <4127FD5A.90605@superbug.demon.co.uk> <41283EDA.6080501@dastyle.net> <DF012E80-F3F1-11D8-A7C9-000393ACC76E@mac.com>
In-Reply-To: <DF012E80-F3F1-11D8-A7C9-000393ACC76E@mac.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Aug 22, 2004, at 02:36, Jonathan Bastien-Filiatrault wrote:
>
>> My dad had a thing like that(quick reference card) for an old 
>> motorola 6800(not 68000) processor. It only had 2 8-bit general 
>> purpose registers if I remember correctly. Doesn't even begin to 
>> compare with modern ppc processors.
>
>
> Hey! I built a primitive computer from one of those in a 
> microprocessor class a year ago.  2 8-bit registers, 8-bit data-bus 
> and 16-bit address bus.  There were two interrupt pins, IRQ and NMI, 
> and a simple condition code register.  The CPU clock is the same as 
> the bus clock.  What fun!!!
>

Here's where I feel my age... 6502 with ONE (That's 1) general purpose 
register (Called the accumulator)... Plus a couple of others used mainly 
for offsets (X & Y if I remember correctly)... No 16-bit maths... All 
8-bit. (As were the registers). Boy the 6809 was easy to program after 
that sucker...

The 6809 (basically an extension of the original 6800)  had 2x 8-bit 
registers IIRC, that you could actually treat as a single 16-bit 
register as well (i.e. multiply one 8bit by the seocnd & read the result 
from the '16-bit' register... The assember language on the 6800 series 
was way better than the 6502 (And the 6510).

but I digress... Even IBM were good with open source. I think I still 
have an IBM PC tech reference around here with the complete source code 
listing (In x86 assembler) of the original IBM PC Bios. Now that made 
for innovation... Open hardware & software. Heck most of these companies 
need a good reminder that if they hadn't had a leg up fro Open computing 
in the early 80's they wouldn't be here today.

H
