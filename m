Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSJHJGc>; Tue, 8 Oct 2002 05:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSJHJGc>; Tue, 8 Oct 2002 05:06:32 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:50317 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261554AbSJHJGb>;
	Tue, 8 Oct 2002 05:06:31 -0400
Date: Tue, 8 Oct 2002 11:11:57 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Nicolas Pitre <nico@cam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021008111157.A5373@ucw.cz>
References: <20021007203714.GC7428@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0210071646170.913-100000@xanadu.home> <20021007211009.GE7428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021007211009.GE7428@atrey.karlin.mff.cuni.cz>; from pavel@suse.cz on Mon, Oct 07, 2002 at 11:10:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:10:09PM +0200, Pavel Machek wrote:
> Hi!
> 
> > At which point he'll piss of more and more kernel developers and lose them
> > "slowly" as well, unless Linus himself gets pissed at which point the kernel
> > user base will disappear in a single glitch.  Breaking SCCS compatibility
> > "slowly" without anybody noticing before it's too late is a bit far fetched
> > IMHO.
> 
> I hope you are right.

He is, I use the SCCS functionality regularly, because patch(1) knows
SCCS and can get the files right from the repository without the need to
check them out using BK.

If that stopped working, I'd notice immediately.

-- 
Vojtech Pavlik
SuSE Labs
