Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbSJDPO2>; Fri, 4 Oct 2002 11:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbSJDPNi>; Fri, 4 Oct 2002 11:13:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55513 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262008AbSJDPMl>;
	Fri, 4 Oct 2002 11:12:41 -0400
Date: Fri, 4 Oct 2002 17:28:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: O(1) Scheduler from Ingo vs. O(1) Scheduler from Robert
In-Reply-To: <1033744512.909.73.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0210041726350.3806-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Oct 2002, Robert Love wrote:

> There should _not_ be other things in the patch aside from the
> scheduler. [...]

hm, i remember there was some 'set max RT priority in .config' stuff in
it, isnt that the case anymore?

> I think the reason my patches differ from Ingo's is that Ingo includes
> code that is not yet in mainline 2.5.  For example, last I checked his
> patches had the SCHED_BATCH stuff, [...]

hm, i forgot about that. Well, it's pretty harmless.

	Ingo

