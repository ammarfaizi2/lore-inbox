Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWAWV0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWAWV0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWAWV0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:26:52 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5090 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964880AbWAWV0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:26:37 -0500
Message-Id: <200601211809.k0LI9bXJ012151@laptop11.inf.utfsm.cl>
To: Michael Loftis <mloftis@wgops.com>
cc: Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE? 
In-Reply-To: Message from Michael Loftis <mloftis@wgops.com> 
   of "Sat, 21 Jan 2006 00:22:03 PDT." <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Sat, 21 Jan 2006 15:09:37 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 23 Jan 2006 18:26:31 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis <mloftis@wgops.com> wrote:

[...]

> The thread in part diverged into three separate discussions more or
> less. I still have a big problem with how the development of the
> kernel is being done now, with a total lack of a stable branch.
> Stable in my mind also means not a moving target for developers, nor
> maintainers.  Try maintaining a lot of very demanding applications
> that must run right so changes must always be fully tested before
> rolling out.  It makes it nearly impossible to do that when the kernel
> has no stable branch that's mostly bug fixes, instead any time a bug
> is discovered a full process must be started to make sure no new bugs
> in all the new code features, etc, that became present during the
> interim are not found.  It makes maintenance a real nightmare for
> atleast one environment in which I maintain production systems, and
> also makes it rather a bit more difficult in others too since changes
> must be vetted.  Not necessarily *all* of them, but when there's lots
> of changes it's hard to track whats 'interesting' and what doesn't
> affect one.  If there was/is a stable tree then when bugfixes come
> they are applied there, and one can upgrade along that tree with much
> less concern about things changing underfoot.

What has changed underfoot you? If it affects userspace, I gather that
would be considered a bug (or you doing nasty things you shouldn't have
done in the first place). 

> That's my root problem.  The devfs stuff is just ancillary and came
> about as examples of where I've been backed into a no win situation.

No. /You/ decided to paint yourself into a tight corner there. Ad did it
carefully, over a couple of years.

[...]

> Over on my end I have to make a decision as to if I have the time to
> try to...promote/lead some sort of effort along these lines so that we
> can all benefit instead of just those willing to use and install
> RedHat or SuSE or Debian or Ubuntu or whatever distro.

Ask the Red Hat people how much it costs them to keep the stuff up to date
for RHEL... better go for 2.4.x or so.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
