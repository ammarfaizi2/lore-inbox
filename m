Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSGBPP3>; Tue, 2 Jul 2002 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSGBPP2>; Tue, 2 Jul 2002 11:15:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15888 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316795AbSGBPP2>; Tue, 2 Jul 2002 11:15:28 -0400
Date: Tue, 2 Jul 2002 11:13:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <Pine.NEB.4.44.0207012045110.24810-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.3.96.1020702110848.27954D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Adrian Bunk wrote:

> This is IMHO a very bad idea:
> - A stable base to start new development upon is a very good thing
>   (and I don't believe in the stability of 2.6.0).
> - Something I'd call the "Debian syndrome" will appear:
>     There are only very few developers who run Debian stable because even
>     during the release cycle there's always an unstable tree. One of the
>     results is that many of the Debian developers aren't that much
>     focussed on working on the next stable release (the current stable
>     release of Debian is nearly two years old and doesn't support kernel
>     2.4...).
>   If 2.7 doesn't start before 2.6 is _really_ stable everyone who wants
>   to have a new development tree is more interested in making 2.6 a really
>   good kernel instead of focussing immediately on 2.7 .

Seems the reason this is being suggested is that lots of new stuff got
shoved into 2.2 and 2.4 in the early stages, and they were NOT stable.
Since far more influential people than I are suggesting this, obviously at
least some of the folks feel it's worth trying something different.

The maintainer can alway push really new stuff into 2.7, and Linus can
always refuse to take a feature into 2.7 until something else is fixed in
2.6. Looking at how hard people are working to backport things from 2.5 to
2.4 I have faith that extra effort will be taken.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

