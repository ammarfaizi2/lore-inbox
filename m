Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293520AbSBZFGY>; Tue, 26 Feb 2002 00:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSBZFGO>; Tue, 26 Feb 2002 00:06:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38161 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S293520AbSBZFF5>; Tue, 26 Feb 2002 00:05:57 -0500
Date: Tue, 26 Feb 2002 00:04:37 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
In-Reply-To: <20020225233230.GB11786@merlin.emma.line.org>
Message-ID: <Pine.LNX.3.96.1020226000221.20055B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Matthias Andree wrote:

> I'd think that running a script to "upgrade" 2.4.N-rcM to 2.4.N by just
> unpacking that latest rc tarball, editing the Makefile and tarring
> things up again, should be safe enough, and if it doesn't allow for
> operator interference, especially so. 

Seems to me:
- clean EXTRAVERSION
- make new diff
- make tar (one please)
- make tar.gz from tar
- compress tar to tar.bz2

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

