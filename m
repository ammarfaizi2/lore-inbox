Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262136AbSJAREM>; Tue, 1 Oct 2002 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbSJARDS>; Tue, 1 Oct 2002 13:03:18 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:65423 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262136AbSJAQ4y>;
	Tue, 1 Oct 2002 12:56:54 -0400
Date: Tue, 1 Oct 2002 19:02:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001190217.B13811@ucw.cz>
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com> <20021001122504.GC3234@tricia.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001122504.GC3234@tricia.dyndns.org>; from jlnance@intrex.net on Tue, Oct 01, 2002 at 08:25:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:25:04AM -0400, jlnance@intrex.net wrote:
> On Tue, Oct 01, 2002 at 12:32:47AM -0700, Linus Torvalds wrote:
> 
> > And if it wasn't clear to the non-2.5-development people out there, yes
> > you _should_ also test this code out even before the freeze. The IDE layer
> > shouldn't be all that scary any more, and while there are still silly
> > things like trivially non-compiling setups etc, it's generally a good idea
> > to try things out as widely as possible before it's getting too late to
> > complain about things..
> 
> Do the ps/2 mouse and the keyboard work like they did in 2.4 (same /dev
> major/minor)?  I tried 2.5 early on but quit because I couldnt see my
> input devices.  At the time I posted a note and got some responses, but
> it appeared that I would have to change things around such that they
> wouldnt work with 2.4 anymore, which I was not willing to do.

If you enable enough options they work interchangeably with 2.4, yes.

-- 
Vojtech Pavlik
SuSE Labs
