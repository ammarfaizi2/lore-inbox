Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287324AbRL3Dyl>; Sat, 29 Dec 2001 22:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287327AbRL3DyW>; Sat, 29 Dec 2001 22:54:22 -0500
Received: from ns.suse.de ([213.95.15.193]:7178 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287324AbRL3DyJ>;
	Sat, 29 Dec 2001 22:54:09 -0500
Date: Sun, 30 Dec 2001 04:54:08 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Oliver Xymoron <oxymoron@waste.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011229184921.B27114@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112300415230.3122-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Larry McVoy wrote:

> that people avoid merge conflicts because they hurt, because of
> the poor tools.
>
>     "Docter it hurts when I have to merge"
>     "So don't do that."

What I've seen happen quite frequently...

developer a: "Hey, here's a patch to do aaaa"

maintainer: "Ah, I've already sent Linus a patch to merge changes from
developer b in this area, but your changes look ok. can you resync when
Linus puts next patch out, and send me the rediffed copy again?"

developer: "Sure, no problem".

Alternatively its maintainer telling developer a "Ah, I've a bunch of
stuff queued from developer b, you guys need to talk on this and work
out how to get this stuff working together, get back to me when you've
work it out".

People management rather than source management systems.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

