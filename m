Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSK0MTv>; Wed, 27 Nov 2002 07:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSK0MTv>; Wed, 27 Nov 2002 07:19:51 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:54227 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262446AbSK0MTu> convert rfc822-to-8bit; Wed, 27 Nov 2002 07:19:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Joshua Kwan <joshk@mspencer.net>
Subject: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Date: Wed, 27 Nov 2002 13:26:35 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
References: <200211270939.38410.m.c.p@wolk-project.de> <20021127025752.7c44482b.joshk@mspencer.net>
In-Reply-To: <20021127025752.7c44482b.joshk@mspencer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211271326.35003.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 November 2002 11:57, Joshua Kwan wrote:

Hi Joshua,

> Not good! Not good!
> Booted fine with no oops or DRI init errors while starting X.
> and the quake3 test, alas:

> - went into 640x480 correctly but would not display the opening movie;
> - keyboard stopped responding and I had to hard-shutdown.
> - i was wearing headphones too and I got some big static from my sound card
> :X
hmm, I don't have any problems with it. Quake3 works fine, opening Movie 
works, no lockups with mouse/keyboard or similar.

maybe the radeon code has also another bug, rage128 works.

ciao, Marc
