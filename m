Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129532AbQK0Vhr>; Mon, 27 Nov 2000 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129563AbQK0Vh2>; Mon, 27 Nov 2000 16:37:28 -0500
Received: from innerfire.net ([208.181.73.33]:13576 "HELO innerfire.net")
        by vger.kernel.org with SMTP id <S129532AbQK0VhS>;
        Mon, 27 Nov 2000 16:37:18 -0500
Date: Mon, 27 Nov 2000 13:09:37 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Mandrake Install <install@linux-mandrake.com>
Subject: Re: Universal debug macros.
In-Reply-To: <3A22A0C9.6888B08@transmeta.com>
Message-ID: <Pine.LNX.4.10.10011271305300.18667-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, H. Peter Anvin wrote:

> Chmouel Boudjnah wrote:
> > 
> > "H. Peter Anvin" <hpa@transmeta.com> writes:
> > 
> > > > > Something RedHat & co may want to consider doing is providing a basic
> > > > > kernel and have, as part of the install procedure or later, an
> > > > > automatic recompile and install kernel procedure.  It could be
> > > > > automated very easily, and on all but the very slowest of machines, it
> > > > > really doesn't take that long.
> > > >
> > > > this completely not possible to do in regard of the end-users eyes.
> > > >
> > >
> > > Why not?
> > 
> > slow !! end-user want to install a distribution fast !!!
> > 
> > it need a lot to be friendly the compilation (ie: we cannot do only
> > launch of make xconfig, not everyone now which options to select),
> > what we can do is a detection of the module and recompile a kernel
> > with the detected module for recompilation but there is too much error
> > case that could not be handle.
> > 
> 
> It's not that slow compared to a whole distro install, although you would
> of course want to do it *optionally*.  You wouldn't want to get into
> every single option, of course, but I thought that was obvious
> (apparently not.)  The drivers and stuff is the least of the problem --
> there, you can use modules anyway.
> 
> 	-hpa
> 

End users have bee known to try a kernel compile.. 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
