Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSFWR5B>; Sun, 23 Jun 2002 13:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFWR5A>; Sun, 23 Jun 2002 13:57:00 -0400
Received: from otter.mbay.net ([206.55.237.2]:21005 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S317072AbSFWR47> convert rfc822-to-8bit;
	Sun, 23 Jun 2002 13:56:59 -0400
From: John Alvord <jalvo@mbay.net>
To: "jdow" <jdow@earthlink.net>
Cc: "Rob Landley" <landley@trommello.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Jeff Garzik" <jgarzik@mandrakesoft.com>,
       "Larry McVoy" <lm@bitmover.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "Cort Dougan" <cort@fsmlabs.com>, "Benjamin LaHaise" <bcrl@redhat.com>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Robert Love" <rml@tech9.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Date: Sun, 23 Jun 2002 10:56:13 -0700
Message-ID: <sr2chugf2bu4pd8a6m3sc36ggemomk4o3o@4ax.com>
References: <E17LmrQ-0002vp-00@the-village.bc.nu> <05ce01c21a31$1a2c3660$1125a8c0@wednesday>
In-Reply-To: <05ce01c21a31$1a2c3660$1125a8c0@wednesday>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002 14:09:30 -0700, "jdow" <jdow@earthlink.net> wrote:

>From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
>
>> > A microkernel design was actually made to work once, with good performance.
>> > It was about fifteen years ago, in the amiga.  Know how they pulled it off?
>> > Commodore used a mutant ultra-cheap 68030 that had -NO- memory management
>> > unit.
>>
>> Vanilla 68000 actually. And it never worked well - the UI folks had
>> to use a library not threads. The fs performance sucked
>
>Some things just cannot be passed by..... The Amiga HAS worked well and
>DOES work well - - - FINALLY. (It took several years and a VERY serious
>debugging effort with Bill Hawes and Bryce Nesbitt finding and quashing
>all manner of bad or missing pointer checks and the like. They made the
>OS itself a remarkable work of art.)

Was that the same Bill Hawes who hung around L-K quashing bugs for a
year or so (maybe 3-4 years ago?)

john alvord
