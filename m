Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTIHT7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbTIHT7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:59:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10766 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263625AbTIHT7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:59:16 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Scaling noise
Date: 8 Sep 2003 19:50:21 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjimht$9dr$1@gatekeeper.tmr.com>
References: <20030903040327.GA10257@work.bitmover.com> <3F55907B.1030700@cyberone.com.au> <27780000.1062602622@[10.10.2.4]> <20030903153901.GB5769@work.bitmover.com>
X-Trace: gatekeeper.tmr.com 1063050621 9659 192.168.12.62 (8 Sep 2003 19:50:21 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030903153901.GB5769@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:

| It's really easy to claim that scalability isn't the problem.  Scaling
| changes in general cause very minute differences, it's just that there
| are a lot of them.  There is constant pressure to scale further and people
| think it's cool.  You can argue you all you want that scaling done right
| isn't a problem but nobody has ever managed to do it right.  I know it's
| politically incorrect to say this group won't either but there is no 
| evidence that they will.

I think that if the problem of a single scheduler which is "best" at
everything proves out of reach, perhaps in 2.7 a modular scheduler will
appear, which will allow the user to select the Nick+Con+Ingo
responsiveness, or the default pretty good at everything, or the 4kbit
affinity mask NUMA on steroids solution.

I have faith that Linux will solve this one one way or the other,
probably both.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
