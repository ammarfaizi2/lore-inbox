Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTBQU5b>; Mon, 17 Feb 2003 15:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTBQU5b>; Mon, 17 Feb 2003 15:57:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25619 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267474AbTBQU5a>; Mon, 17 Feb 2003 15:57:30 -0500
Date: Mon, 17 Feb 2003 16:03:32 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rus Foster <rghf@fsck.me.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Insprion Battery Level
In-Reply-To: <20030217155735.O88375-100000@freebsd.rf0.com>
Message-ID: <Pine.LNX.3.96.1030217155920.914A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2003, Rus Foster wrote:

> Hi,
> Sorry if this is the wrong place. I'm trying to work out if there is
> anyway to get power levels out of the battery. I've enabled Dell Laptop
> support and ACPI but can't find anything. Is there a userspace tool I need
> to install at all?

I've used a couple of Dells, Lattitudes and Inspirons, and using APM
rather than ACPI worked, the apm command gave me battery status and IIRC
"apm -s" worked to put the Lattitude to sleep.

Don't know if this will work for you or is all you need, it met my humble
needs.

Note: this was with a 2.4 kernel, I don't recall if I tested the 2.5 for
this particular ability.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

