Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288952AbSBOMgU>; Fri, 15 Feb 2002 07:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288958AbSBOMgK>; Fri, 15 Feb 2002 07:36:10 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:20754 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S288952AbSBOMfx>; Fri, 15 Feb 2002 07:35:53 -0500
Date: Fri, 15 Feb 2002 23:36:42 +1100
From: john slee <indigoid@higherplane.net>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Robert Love <rml@tech9.net>, J Sloan <joe@tmsusa.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tux officially in kernel?
Message-ID: <20020215123642.GB5996@higherplane.net>
In-Reply-To: <Pine.LNX.4.30.0202111313100.28040-100000@mustard.heime.net> <3C67F327.8010404@tmsusa.com> <20020213135841.GB4826@higherplane.net> <3C6C4942.4050305@lexus.com> <1013730883.807.251.camel@phantasy> <20020214190003.B1518@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020214190003.B1518@asooo.flowerfire.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 07:00:03PM -0600, Ken Brownfield wrote:
> The problem with X15 is that it's unavailable.  I've tried for months
> and months to get someone at that company to respond or get a copy to
> try.  Also, is it GPL?  Free?

i believe it was free for noncommercial use, a restriction imposed by
the author's company.  i didn't bother to read back on the archives
though so don't accept this as verified fact :-)

> As for TUX, I would certainly prefer user-space if it was indeed as fast

also thttpd is very very fast on linux.  really to need this sort of
performance on modern hardware is quite unusual at least in the public
internet.

> in all cases.  But I don't think X15 is really a factor in TUX's

maybe not x15 on its own.  but the existence of multiple userspace
servers that can provide similar performance may be a good reason to not
include it, as well as ...

> inclusion.  I'd say replacing khttpd with TUX2 is a no-brainer unless
> X15's performance has been proven and it's GPL.  And while khttpd is an

there's no reason why it can't stay as an external patch.  redhat provide
tux rpms for example.  i think khttpd should be removed altogether from
the standard kernel and not replaced with tux.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
