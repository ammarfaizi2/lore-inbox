Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276640AbRJKSPV>; Thu, 11 Oct 2001 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276650AbRJKSPM>; Thu, 11 Oct 2001 14:15:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17157 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276640AbRJKSO7>; Thu, 11 Oct 2001 14:14:59 -0400
Date: Thu, 11 Oct 2001 14:15:28 -0400
Message-Id: <200110111815.f9BIFSZ17993@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Breaking system configuration in stable kernels
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.3.95.1011009151209.3636A-100000@chaos.analogic.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1011009151209.3636A-100000@chaos.analogic.com>
	root@chaos.analogic.com wrote:

| As I see it, you get the chance to complain about some poor performance
| because you don't have anything to compare present performance against.
| So, you upgrade to a minimally-tested kernel and complain that it's
| not a "viable candidate for default o/s..." -your words. Guess what,
| this complaint will always fall upon deaf ears.
| 
| What will help get your bleeding-edge kernel stable, is a bug report,
| a performance report, and sometimes even a "Hey... This one works great!".
| 
| Don't ever expect the kernel's internals to remain constant. This means
| that you will have to modify any of your custom modules for each and
| every kernel you download.
| 
| You can expect the API to remain constant. If it doesn't you have
| a valid beef. Otherwise, you will be talking to the forest. 

  There seems to be confusion about the meaning of "stable." The stable
kernel series should be getting bug fixes, and the untested changes
should go into the development (like 2.5) series where no one would
expect it to be stable.

  There should be no bleeding edge stable kernels, my point exactly. As
long as Linux behaves like a hacker's dream it will be perceived as
such. When a stable kernel is released someone interested in reliable
operation should take it over. We should not have "oh, shit, don't use"
stable versions. For all the new features, the -ac kernels have
consistently been more stable, because, as Alan says, "I run these
kernels on my machines" and they behave like it.

| Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
| 
|     I was going to compile a list of innovations that could be
|     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
|     was handled in the BIOS, I found that there aren't any.

  Microsoft has actually had two good ideas; the software floating
point in the FORTRAN compiler for the 8080 CP/M system (one extra bit
of precision) and MS-CHAP to prevent clear text passwords from passing
on the net. Can't think of anything else which impressed me...

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe

