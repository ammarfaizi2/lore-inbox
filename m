Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTLCUzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTLCUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:55:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7179 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261877AbTLCUzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:55:25 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: XFS for 2.4
Date: 3 Dec 2003 20:44:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlhuv$jh2$1@gatekeeper.tmr.com>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com> <20031202180251.GB17045@work.bitmover.com>
X-Trace: gatekeeper.tmr.com 1070484255 20002 192.168.12.62 (3 Dec 2003 20:44:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031202180251.GB17045@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
| On Tue, Dec 02, 2003 at 12:45:38PM -0500, Murthy Kambhampaty wrote:
| > If you can't come up with something more concrete than "I don't like your
| > coding style" and "I'm not sure your patch won't break something", it seems
| > only fair you take the XFS patches.
| 
| Not your call, it's Marcelo's call.  And I and he have both suggested
| that the way to get XFS in is to have someone with some clout in the file
| system area agree that it is fine.  It's a perfectly reasonable request
| and the longer it goes unanswered the less likely it is that XFS will get
| integrated.  The fact that $XFS_USER wants it in is $XFS_USER's problem.
| $VFS_MAINTAINER needs to say "hey, this looks good, what's the fuss about?"
| and I suspect that Marcelo would be more interested.

Linus accepted it for 2.6, does it need to be blessed by the Pope, or what?
| 
| It is not, however, any more my call to make than it is your call to make.
| We're not doing Marcelo's job.
| 
| It is also not unreasonable to reject a set of changes right before
| freezing 2.4.  2.4 is supposed to be dead.  Add XFS and what's next?
| Who's pet feature needs to go in?

Now that is bullshit and you know it! This is not a pet feature, this
is code which has has been stable for years. There just aren't any
other candidates, all the other FS stuff went in with less testing and
have fewer users now (JFS as example). This is also not code offered
"right before a freeze" this code has been offered version by version
for two bleepin' years, has it not? There's no slippery slope, there
are no other major features which have proven long-term stability. Fell
free to name them if I'm wrong...

Marcelo admits he doesn't like the coding style, he has the right to
keep out anything he doesn't like, but let's not invent other reasons.
It's his call and he made it. It's a pity he didn't make the call
earlier and save people the effort, though.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
