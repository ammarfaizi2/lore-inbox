Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSL3Djd>; Sun, 29 Dec 2002 22:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSL3Djd>; Sun, 29 Dec 2002 22:39:33 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:1295 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S266135AbSL3Djc>; Sun, 29 Dec 2002 22:39:32 -0500
Date: Mon, 30 Dec 2002 14:47:07 +1100
From: john slee <indigoid@higherplane.net>
To: Larry McVoy <lm@work.bitmover.com>, Russ Allbery <rra@stanford.edu>,
       Felix Domke <tmbinc@elitedvb.net>, linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230034707.GD18508@higherplane.net>
References: <fa.f9m4suv.e6ubgf@ifi.uio.no> <ylfzsgi3jz.fsf@windlord.stanford.edu> <20021230034303.GA11425@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230034303.GA11425@work.bitmover.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 07:43:03PM -0800, Larry McVoy wrote:
> On Sun, Dec 29, 2002 at 07:33:20PM -0800, Russ Allbery wrote:
> > Felix Domke <tmbinc@elitedvb.net> writes:
> > 
> > > i don't want to change anything, i just like to know WHY people use
> > > spaces. are they somehow unportable? (i don't think so)
> > 
> > <http://www.jwz.org/doc/tabs-vs-spaces.html>
> 
> Quouting from that page:
>     That ensures that, even if I happened to insert a literal tab in the
>     file by hand (or if someone else did when editing this file earlier),
>     those tabs get expanded to spaces when I save. 
> 
> If you are using a source management system, pretty much *any* source
> management system, doing this will cause all the lines to be "rewritten"
> if they had tabs.  The fact that this person would advocate changing
> code that they didn't actually change shows a distinct lack of clue.
> No engineer who works for an even semi-pro company would dream of doing
> this.  At BitMover, anyone who seriously advocated this for more than
> a day would be fired.

well, he DID work at netscape...

j.

-- 
toyota power: http://indigoid.net/
