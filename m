Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTE0EIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTE0EIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:08:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60423 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263199AbTE0EIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:08:21 -0400
Date: Tue, 27 May 2003 06:21:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Willy Tarreau <willy@w.ods.org>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030527042116.GA19309@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave> <20030524064340.GA1451@alpha.home.local> <1053923112.14018.16.camel@rth.ninka.net> <Pine.LNX.4.55L.0305261541320.20861@freak.distro.conectiva> <20030526212902.GA13550@alpha.home.local> <Pine.LNX.4.55L.0305261830180.29936@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305261830180.29936@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:35:51PM -0300, Marcelo Tosatti wrote:
 
> What I said is that if people think I'm not maintaining 2.4.x (quoting
> Davem, "I really think 2.4.x development is becoming almost non-existent
> lately.) in a acceptable way, the work should be done by someone else. I
> WANT to keep maintaining 2.4, but only if people are happy with that. Do
> you understand ?

Yes, I understand. I think it's good that people have complained because now
you know what they expect from you, so it's up to you to make them happy :)

> > People often prefer "here is -rcxx-acxx, which my EPIA now fully
> > supports" to "here is -rcxx, please test it extensively".
> 
> I dont understand what you mean.

John correctly replied for me. Several -pre didn't even compile for most of us,
but you let them as they were during weeks. When this happens, only a few people
who have the time to follow LKML and grab patches can try these pre-releases.
When that happens, please do apply the trivial fixes and send one more just
after, even the same day so that people can try them. Alan often does this, and
nobody has ever complained about him for releasing 2 kernels the same day, one
with a big bug and the next one without.

I already had collegues saying to me "Yesterday, I've tried to compile
2.4.21-preXX, but it doesn't compile". It's always sad to say to them "wait 3
weeks, hoping for the next one to fix it and not to add new bugs !". I'd really
prefer to reply "you idiot, return to kernel.org and get the next one or send a
patch, Marcelo wouldn't let his kernel in this state".

Regards,
Willy

