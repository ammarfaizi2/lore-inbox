Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSKGQ1W>; Thu, 7 Nov 2002 11:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261446AbSKGQ1V>; Thu, 7 Nov 2002 11:27:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19724 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261425AbSKGQ1T>; Thu, 7 Nov 2002 11:27:19 -0500
Date: Thu, 7 Nov 2002 11:33:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: yet another update to the post-halloween doc.
In-Reply-To: <1036599481.3405.1080.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1021107112618.30525B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Nov 2002, Robert Love wrote:

> > procps
> > ~~~~~~
> > - The 2.5 /proc filesystems changed some statistics, which confuse
> >   older versions of procps. Rik van Riel and Robert Love have
> >   been maintaining a version of procps during the 2.5 cycle which
> >   tracks changes to /proc which you can find at http://tech9.net/rml/procps/
> > - Alternatively, the original procps by Albert Cahalan now supports
> >   the altered formats since v3.0.5, but lags behind the bleeding edge
> >   version maintained by Rik and Robert. -- http://procps.sf.net/
> > - The /proc/meminfo format changed slightly which also broke
> >   gtop in strange ways.
> 
> Just a note that the tree Rik and I are hacking on is the original and
> not a fork.  It is the same tree mkj created and is in the official Red
> Hat CVS repository.  It just has not had much activity lately and now it
> has new blood :)
> 
> Albert's tree is a fork.
> 
> If you are using the official procps package, I think you need at least
> 2.0.8 or so - but the latest version is ideal, which is 2.0.10.

  I don't want to get into politics on this, but wasn't Albert the
maintainer of procps? I think I saw him state that you guys started
releasing your own versions instead of sending him patches,

  I can't find a maintainer's name in any of the not so old versions I
have here, so I am just replaying my recollection of his statement as a
question.

  For what it's worth, both recent versions seem to work, his top is far
prettier;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

