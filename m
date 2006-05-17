Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWEQEVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWEQEVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 00:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWEQEVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 00:21:25 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61200 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751223AbWEQEVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 00:21:24 -0400
Date: Wed, 17 May 2006 06:21:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
Message-ID: <20060517042116.GR11191@w.ods.org>
References: <4469D296.8060908@perkel.com> <20060516200313.GO11191@w.ods.org> <yw1xfyj91y6n.fsf@agrajag.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xfyj91y6n.fsf@agrajag.inprovide.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 10:01:36PM +0100, Måns Rullgård wrote:
> Willy Tarreau <willy@w.ods.org> writes:
> 
> > On Tue, May 16, 2006 at 06:24:38AM -0700, Marc Perkel wrote:
> >> As most of you know the United States is tapping you telephone calls and 
> >> tracking every call you make. The next logical step is to start tapping 
> >> your computer implanting spyware into operating systems. Since Windows 
> >> and OS-X are proprietary this can be done more easilly with the 
> >> cooperation of Microsoft and Apple.
> >> 
> >> So what about Linux? With thousands of people working on the Kernel if 
> >> someone from the NSA wanted to slip a back door into the Kernel, could 
> >> the do that? I know it's open source and it could be found if anyone 
> >> looks but is anyone looking? Is this something that would get noticed if 
> >> someone tried to do it? I'd like to think it would, but I'm going to ask 
> >> anyway just to make sure.
> >
> > There is no warranty that this cannot happen. Indeed, it has already
> > happened and will probably do again. A backdoor was found in some code
> > introduced in the bitkeeper repository, but it was noticed almost
> > immediately.
> 
> The code was not added to the bitkeeper repository, but to a CVS
> mirror of it.  It was spotted quickly thanks to rigorous checksumming
> done by the CVS exporter in BK.
> 
> One of the current trends in version control software is toward
> cryptographically signed changesets, meaning that sneaking something
> in without access to a trusted private key is about as close to
> impossible as you can get.
> 
> There is still the question of who you can *really* trust of course.
> After all, how do we know that Dave Miller (who was "credited" for the
> mentioned backdoor attempt) isn't really a bad guy?

That's true, and even for all other people, those who design the code
and make choices. At one moment, you have to decide whether you trust
those people and their code or whether you prefer to switch back to
closed commercial code with the same risk of backdoors but without a
way to detect them. I decided to trust them as well as some people
trust me for the hotfixes I release from time to time. And when
someone does crap, he's not trusted anymore. That's very simple.

> -- 
> Måns Rullgård
> mru@inprovide.com

Regards,
Willy

