Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTICS4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTICSzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:55:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57870 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264304AbTICSvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:51:48 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 64 bit jiffies for 2.4.23-pre2
Date: 3 Sep 2003 18:43:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj5cnr$8ma$1@gatekeeper.tmr.com>
References: <Pine.LNX.4.44.0309011509270.6008-100000@logos.cnet> <Pine.LNX.4.33.0309012024320.26435-100000@gans.physik3.uni-rostock.de> <20030901190210.GA24145@alpha.home.local>
X-Trace: gatekeeper.tmr.com 1062614587 8906 192.168.12.62 (3 Sep 2003 18:43:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030901190210.GA24145@alpha.home.local>,
Willy Tarreau  <willy@w.ods.org> wrote:

| Ok, thanks Tim, I'll keep including it in my kernel since it allows my systems
| to live such a long life :-) But I don't think they will ever beat Alan's box
| which lasted 1100 days on 1.2.13 ! And that would not be reasonable because
| even for security reasons, you sometimes have to upgrade.

That 1.2.13 was very stable, my glacial.tmr.com DNS server ran from
shortly after 1.2.13 came out (I had 1-2 patches applied) until Dec 30
1999 when I shut it down because of suspected Y2k issues. It was called
glacial because it was on a 12MB 386sx-16, not because it was so cool;-)

Alan's machine got much more use than mine, but it probably had a lot
more fixes.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
