Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTKPREs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 12:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTKPREr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 12:04:47 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263057AbTKPREo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 12:04:44 -0500
Date: Sun, 16 Nov 2003 18:05:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: mfedyk@matchmail.com, reiser@namesys.com, herbert@gondor.apana.org.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031116170509.GB201@elf.ucw.cz>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031116130558.GB199@elf.ucw.cz> <20031116151522.6ef9d2e1.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116151522.6ef9d2e1.skraw@ithnet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If distribution had all packages unmodified, it would be useless...
> 
> Just contrary I'd state that this would be the "perfect world", because this
> would mean all projects are in perfect shape and all patches have gone to the
> respective maintainers.

Okay, in the perfect world we'd have just one distribution with all
packages unmodified. Well.. but we are not there yet.

> > So I'd expect all distros to have at least some changes in their
> > kernel... the same way I expect distros to have some patches in
> > midnight commander etc.
> 
> So you say midnight commanders' maintainer is an a**hole, or what?
> If you think some project needs patches, then please talk to its

Debian having diffs vs. vanilla midnight does not mean anything
negative about its maintainer: Debian well may want different default
config, for example (F3 viewer bindings came to mind).

> > Of course it is good to keep the .diff as small as possible.
> 
> diffsize small is wanted.
> diffsize zero is unwanted.
> What kind of a logic is that?
> 
> Forgive me Pavel, that does not sound thoughtful to me.

If there's bug in the package, I expect Debian to fix the bug and then
forward bugfix to the maintainer.

Distribution does not want to wait for maintainer to ACK, especially
if its security-related bug.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
