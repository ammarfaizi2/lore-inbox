Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTKXXmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbTKXXmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:42:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:518 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261686AbTKXXmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:42:02 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Intel centrino drivers being withheld?
Date: 24 Nov 2003 23:31:05 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpu4bp$vp8$1@gatekeeper.tmr.com>
References: <200311240950.28769.andrew@walrond.org>
X-Trace: gatekeeper.tmr.com 1069716665 32552 192.168.12.62 (24 Nov 2003 23:31:05 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200311240950.28769.andrew@walrond.org>,
Andrew Walrond  <andrew@walrond.org> wrote:
| Is anybody liasing, asisting or pressuring Intel wrt centrino wireless 
| drivers?
| 
| It seems to me that it could have been written at least 20 times over during 
| the time they've supposedly been in development.

Have you looked at the Intel2100 driver linked from TuxMobil? Not ready
for prime time yet, but someone is working on the problem. For that
metter, *is* someone bugging Intel? I'd hate to have them say "no one
asked," but stranger things have happened.
| 
| This quote from back in March annoys me somewhat:
| 
| "The Santa Clara, Calif., chip maker is running Linux drivers in its labs, but 
| whether or not those drivers make it out of the labs depends on customer 
| demand, said Scott McLaughlin, an Intel spokesman"
| 
| Well, I am demanding, and my patience is running very thin. And Amd look to be 
| releasing 64bit mobile parts soon, and appear to be very linux friendly. Am I 
| the only one getting annoyed about this?

At the moment the Pentium-M seems to be about the longest life per pound
going, which makes it desirable when life is more important than
computing power. If a few hours is long enough there are lots of choices.
| 
| Can anybody put my mind at rest, or suggest reasons why Intel may be reluctant 
| to release the drivers?

They may not be in a state to release. The Intel web site clearly says
they are under development, before we decide Intel doesn't love us it
would be nice to get an answer on this from one of the Intel folks who
read this list.

It could be releated to the state of APM/ACPI/suspend in 2.6, I think
"immature" is realistic compared to 2.4, a lot of work has gone into
it, but if the 2100 needs ACPI support, that might be an issue. It
might not keep Intel from doing a 2.4 driver, though.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
