Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRBSQFd>; Mon, 19 Feb 2001 11:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRBSQFX>; Mon, 19 Feb 2001 11:05:23 -0500
Received: from [193.120.224.170] ([193.120.224.170]:5250 "EHLO florence.itg.ie")
	by vger.kernel.org with ESMTP id <S129677AbRBSQFP>;
	Mon, 19 Feb 2001 11:05:15 -0500
Date: Mon, 19 Feb 2001 16:04:54 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: "Henning P . Schmiedehausen" <hps@intermeta.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Werner Almesberger <Werner.Almesberger@epfl.ch>,
        "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
In-Reply-To: <20010219131542.D16663@forge.intermeta.de>
Message-ID: <Pine.LNX.4.32.0102191557260.3627-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Henning P . Schmiedehausen wrote:

> So, is it legal to put changes to a twin licensed driver in the Linux
> kernel tree back into the same driver in the BSD tree?

IANAL, but AIUI:

if the changes are made the copyright holder then they may do whatever
they want. (release the changes only under one licence, both, none,
etc..)

if small changes are made by a 3rd party (eg a patch) and submitted
back to the copyright holder, then it is almost safe to presume that
the copyright holder may incorporate those changes without ceding
copyright in any way. (then see first point)

if major changes are made by a 3rd party then (i think) 3rd party has
copyright over their changes, and so, either:

-copyright holder of the original work would need to comply with the
licence of the derived work. (eg if GPL, then changes can't go back
into the BSD version)

or:

- copyright holder of the original work would need express permission
from the copyright holder of the derived work to use it under a
different licence.

but IANAL most obviously... :)

>
> 	Regards
> 		Henning

--paulj

