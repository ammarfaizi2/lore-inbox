Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSARE4w>; Thu, 17 Jan 2002 23:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290599AbSARE4n>; Thu, 17 Jan 2002 23:56:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18445 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290593AbSARE4e>; Thu, 17 Jan 2002 23:56:34 -0500
Date: Thu, 17 Jan 2002 23:56:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Klaus Meyer <k.meyer@m3its.de>
cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org,
        rwhron@earthlink.net, bcrl@redhat.com
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
In-Reply-To: <3C4782BA.906950C8@m3its.de>
Message-ID: <Pine.LNX.3.96.1020117235335.5060B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Klaus Meyer wrote:

> It was just a bad memory modul. Believe me, i'd tested them before
> carefully.
> But i had to learn that even ECC-modules installed in brand motherboards
> dont tell you that they are not working correctly.

I wonder if your BIOS is doing the right thing setting the ECC config?
That should have been reported.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

