Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWATXCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWATXCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWATXCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:02:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8645 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932270AbWATXCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:02:41 -0500
Message-Id: <200601202300.k0KN0VDQ011246@laptop11.inf.utfsm.cl>
To: Michael Loftis <mloftis@wgops.com>
cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE? 
In-Reply-To: Message from Michael Loftis <mloftis@wgops.com> 
   of "Fri, 20 Jan 2006 13:56:12 PDT." <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 20 Jan 2006 20:00:31 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 20 Jan 2006 20:01:16 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis <mloftis@wgops.com> wrote:
> --On January 20, 2006 11:43:31 AM -0800 Greg KH <greg@kroah.com> wrote:
> > On Fri, Jan 20, 2006 at 10:14:15AM -0700, Michael Loftis wrote:
> >> The problem here is I'm spending a lot of my time lately fixing things
> >> that  shouldn't need fixing.  Things that are/were developed against
> >> what was  supposed to be a stable major version and has been turned into
> >> a  development version.

> > What specifically are you "fixing"?

> At this point I'm looking at bugs in the aic7xxx driver, it mostly
> works in 2.6.8, occasionally locking up my tape subsystem, it's
> apparently fixed in 2.6.15 or 2.6.15.1, I need to look closer into
> that, and backport it because of the devfs issue I don't think I can
> take 2.6.15/2.6.15.1 whole hog.  A decent amount of ARM stuff moving
> around between even just 2.6.11 and 2.6.13 (admittedly that's a gripe
> for ARM) making development for that port very painful (there's talk
> of switching to something else because of all of this for those
> projects) -- no specifics on the ARM stuff as I'm not the developer
> directly involved with most that, I'm just doing some PHY code, which
> will eventually be submitted back to the mainstream ARM (still in
> product development) and he's indisposed today/at the moment, I'll try
> to get him to summarize those issues so I can relay them to the list.

You do realize that doing all that is much more work than just fixing
whatever you are doing wrong with the configuration of your machines, do
you? And that that job /will/ get increasingly harder as time goes by?

Better install anew, it looks like the current situation is beyond hope.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
