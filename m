Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTIJOje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTIJOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:39:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61202 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264699AbTIJOis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:38:48 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test4-mm6
Date: 10 Sep 2003 14:29:53 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjnch1$l5h$1@gatekeeper.tmr.com>
References: <20030905015927.472aa760.akpm@osdl.org>
X-Trace: gatekeeper.tmr.com 1063204193 21681 192.168.12.62 (10 Sep 2003 14:29:53 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030905015927.472aa760.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
| 
| 
| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/
| 
| 
| This is only faintly tested.  It's mainly a syncup with people..

Faintly indeed, it would even boot X on my little test machines :<
Oopsed when I tried to run tcpdump, etc.

Since test5-mm1 came out and doesn't have any of those problems, I will
assume that it escaped rather than was released.

I'll comment on some responsiveness testing on test5-mm1 and earlier
test4 stuff after I build test5-nick15 to include in the testing.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
