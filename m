Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTLCXvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTLCXvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:51:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48139 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262458AbTLCXvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:51:10 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux GPL and binary module exception clause?
Date: 3 Dec 2003 23:40:00 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqls8g$kmd$1@gatekeeper.tmr.com>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.53.0312031648390.3725@chaos>
X-Trace: gatekeeper.tmr.com 1070494800 21197 192.168.12.62 (3 Dec 2003 23:40:00 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0312031648390.3725@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
| On Wed, 3 Dec 2003, Kendall Bennett wrote:
| 
| > Hi All,
| >
| > I have heard many people reference the fact that the although the Linux
| > Kernel is under the GNU GPL license, that the code is licensed with an
| > exception clause that says binary loadable modules do not have to be
| > under the GPL. Obviously today there are vendors delivering binary
| > modules (not supported by the kernel maintainers of course), so clearly
| > people believe this to be true. However I was curious about the wording
| > of this exception clause so I went looking for it, but I cannot seem to
| > find it. I downloaded the 2.6-test1 kernel source code and looked at the
| > COPYING file, but found nothing relating to this (just the note at the
| > top from Linus saying user programs are not covered by the GPL). I also
| > looked in the README file and nothing was mentioned there either, at
| > least from what I could see from a quick read.
| >
| > So does this exception clause exist or not? If not, how can the binary
| > modules be valid for use under Linux if the source is not made available
| > under the terms of the GNU GPL?
| >
| 
| I'll jump into this fray first stating that it is really great
| that the CEO of a company that is producing high-performance graphics
| cards and acceleration software is interested in finding out this
| information. 

Really? I guess I'm just suspicious, but when someone who might have an
interest in only providing a binary driver asks about the legality of
doing that, "great" is not my first thought.

| information. It seems that some other companies just hack together some
| general-purpose source-code under GPL and then link it with a secret
| object file. This, of course, defeats the purpose of the GPL (which is
| or was to PUBLISH software in human readable form).

Yes, I am a devout fundamentalist paranoid, but I've based my life on
the assumptions that I should treat others fairly and expect them to
screw me if they could, and both have served me well.

I do not mean to cast aspersions on the original poster, about whom I
know nothing. There are many companies who have provided full source
drivers, and I have rewarded them with my business. I have chosen less
performance video over binary module hardware, and would be very happy
if there were some guilt-free hardwaree to use. I'm just starting to do
video processing, I'd be *really* happy, ecstatic even.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
