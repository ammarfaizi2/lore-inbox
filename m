Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTAFEBF>; Sun, 5 Jan 2003 23:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTAFEBF>; Sun, 5 Jan 2003 23:01:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40714
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265786AbTAFEBE>; Sun, 5 Jan 2003 23:01:04 -0500
Date: Sun, 5 Jan 2003 20:08:23 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Richard Stallman <rms@gnu.org>
cc: akpm@digeo.com, riel@conectiva.com.br, andrew@indranet.co.nz,
       linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
In-Reply-To: <E18VNt1-0008Rq-00@fencepost.gnu.org>
Message-ID: <Pine.LNX.4.10.10301051947340.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Richard,

Can you admit the follow, that GPL has everything to control
redistribution, and has ZERO context for copyright.  The holders of the
copyright control the issues.

See your whole hook is "Derivative Works" well, I implimented a protocol.
It works regardless of platform or OS.  All it uses are simple and
standard kernel services.

Since I am willing to list every kernel function I call, and see who is
going to object to me doing what everyone else is doing and is clearly
positioned as accepted as of 1995.  If you were not aware of this
position, and I was not either, tough.  Linus sets the rules and he
controls the key interfaces.

Next you have NO ownership in the kernel, so unless you try to collect a
group of copyright holders and advocate on their behalf, I think you are
way out of bounds to even be here, period.  As you have stated already,
this is an issue exclusive to the copyright holders, and you are not one
of us.  So please live by your own words, or state you legal position to
be here in the affairs of the Copyright holders.

Regards,

Andre Hedrick, CTO & Founder
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

On Sun, 5 Jan 2003, Richard Stallman wrote:

>     I suggest that if a function happens to be implemented as an inline
>     in a header then it should be treated (for licensing purposes) as
>     an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.
> 
> The Linux developers can certainly do this, if the copyright holders
> of the substantial functions in question go along with it.  Even if
> they already went along with linking to their functions from non-free
> modules, this is still somewhat different.
> 
> The question only arises for the specific non-small functions that are
> to be inlined in headers in this way.  (Inlining a very small function
> from a header is probably not significant for copyright.)  Perhaps the
> copyright holders of these functions are few and easy to ask.

