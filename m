Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJAM4o>; Tue, 1 Oct 2002 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSJAM4o>; Tue, 1 Oct 2002 08:56:44 -0400
Received: from smtp.intrex.net ([209.42.192.250]:4881 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S261607AbSJAM4o>;
	Tue, 1 Oct 2002 08:56:44 -0400
Date: Tue, 1 Oct 2002 08:25:04 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001122504.GC3234@tricia.dyndns.org>
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 12:32:47AM -0700, Linus Torvalds wrote:

> And if it wasn't clear to the non-2.5-development people out there, yes
> you _should_ also test this code out even before the freeze. The IDE layer
> shouldn't be all that scary any more, and while there are still silly
> things like trivially non-compiling setups etc, it's generally a good idea
> to try things out as widely as possible before it's getting too late to
> complain about things..

Do the ps/2 mouse and the keyboard work like they did in 2.4 (same /dev
major/minor)?  I tried 2.5 early on but quit because I couldnt see my
input devices.  At the time I posted a note and got some responses, but
it appeared that I would have to change things around such that they
wouldnt work with 2.4 anymore, which I was not willing to do.

Thanks,

Jim
