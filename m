Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVDHG7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVDHG7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVDHG7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:59:11 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:11391 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262712AbVDHG6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:58:48 -0400
X-ME-UUID: 20050408065844306.4AA141C00149@mwinf0908.wanadoo.fr
Date: Fri, 8 Apr 2005 08:54:40 +0200
To: Adrian Bunk <bunk@stusta.de>, Sven Luther <sven.luther@wanadoo.fr>,
       Humberto Massa <humberto.massa@almg.gov.br>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408065440.GC27346@pegasos>
References: <h-GOHD.A.KL.s2aUCB@murphy> <42527E89.4040506@almg.gov.br> <20050405135701.GA24361@pegasos> <20050407205647.GB4325@stusta.de> <20050407210505.GB17963@pegasos> <20050408003136.GI4325@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050408003136.GI4325@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 02:31:36AM +0200, Adrian Bunk wrote:
> On Thu, Apr 07, 2005 at 11:05:05PM +0200, Sven Luther wrote:
> > On Thu, Apr 07, 2005 at 10:56:47PM +0200, Adrian Bunk wrote:
> >...
> > > If your statement was true that Debian must take more care regarding 
> > > legal risks than commercial distributions, can you explain why Debian 
> > > exposes the legal risks of distributing software capable of decoding 
> > > MP3's to all of it's mirrors?
> > 
> > I don't know and don't really care. I don't maintain any mp3 player (err,
> > actually i do, i package quark, but use it mostly to play .oggs, maybe i
> > should think twice about this now that you made me aware of it), but in any
> > case, i am part of the debian kernel maintainer team, and as such have a
> > responsability to get those packages uploaded and past the screening of the
> > ftp-masters. I believe the planned solution is vastly superior to the current
> > one of simply removing said firmware blobs from the drivers, which caused more
> > harm than helped, which is why we are set to clarifying this for the
> > post-sarge kernels. 
> 
> 
> Debian doesn't seem to care much about the possible legal problems of 
> patents.

patents are problematic, and upto recently there where no software patents in
europe, so i don't really care. I am not sure about the details of the above
problem you mention, could you provide me some link to the problem at hand. I
also believe that in the larger scheme restriction of this kind, as is the US
restriction on distribution to cuba and everything else, is not-right and even
immoral, and *I* personally would fight back if i was ever sued for such
things, and there may be higher courts involved than just the US judicial
system, which is for sale anyway, where redhat is dependent on. I cannot talk
about the whole of debian on this though, and i feel it is for someone else to
tackle and handle. If you feel strongly about this, you are free to go take it
over with whoever handles this, post to debian-legal and debian-project about
it, and help get the issue solved.

(/me believes such restrictions of the above are a violation of the elemental
human rights to go where one wants and run what operating system on wants).

> The firmware issues are an urgent real problem?

It is a problem that concerns me and the debian kernel team, thus we are out
to fix it. If you have a problem at hand, even if it is not as important as
others, would you sit back and not do anything just because others didn't
solve other problems ? 

> Debian should define how much legal risk they are willing to impose on 
> their mirrors and distributors and should act accordingly in all areas.

That is for the ftp-masters to decide, i am not in best speaking term with
them, so you are free to go ask the question directly.

> But ignoring some areas while being more religious than RMS in other 
> areas is simply silly.

Come on, i am just asking for a damn explicit declaration that the firmware is
not something covered by the GPL, and that we should have explicit
distribution licence for it. We all agree that these are not covered by the
GPL for various reasons, so why not have the copyright holder state it
explicitly ? I don't see how do you jump to "more religious than RMS" from
that, given that my analysis making the firmware aggregate works are a wee bit
different from what they explicitly write in their GPL FAQ.

> > That said, i was under the understanding that after the SCO disaster,
> > clarification of licencing issues and copyright attributions was a welcome
> > thing here, but maybe i misunderstood those whole issues.
> 
> "SCO disaster"?
> 
> It is a disaster for SCO.

Now, yes. but we did strengthen our admission of patches policy for more
tracability, didn't we, and there where companies who paid SCO for fear of
retribution, and they where project who post-poned their linux adoptions, and
what not. If nothing else, be it only for all the time we all lost following
that story over the past tree years.

Friendly,

Sven Luther

