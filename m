Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbTDXViL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTDXViL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:38:11 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50439 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264484AbTDXViI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:38:08 -0400
Date: Thu, 24 Apr 2003 17:44:39 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Stelian Pop <stelian.pop@fr.alcove.com>, Ben Collins <bcollins@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
In-Reply-To: <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1030424173619.11734F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Marcelo Tosatti wrote:

> I guess Ben's mega patch (and yes, I also consider it a megapatch for
> -rc) has to be applied. I just mailed him asking about the possibility
> of getting only fixes in and not the cleanups, but I guess that might be a
> bit hard to do _today_. Right Ben ?
> 
> And about the sweet complaints about -pre timing, I will release -pre's
> each damn week for .22.
> 
> *!@#!&*.

If I might offer a course of action, if you put thing which are *fixes* in
the bk releases, and hold *changes* for the next -pre, it might allow
people to grab bk's to fix the quickly caught things in a new pre, without
being hit with major changes which might decrease stability.

Clearly any pre is a risk, but there always seem to be errors of the "XXX
doesn't compile because of typo" type. That way Alan could put all new IDE
code in each -pre and Andre and others could put fixes in the bk's until
it worked. => JOKING!! <== but you get the idea.

I'd love to see this in 2.5 as well, just to encourage people to use it!
I'm not even going to suggest that, there would be the usual flamewar.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

