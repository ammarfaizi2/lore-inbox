Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTKPNFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTKPNFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:05:54 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262729AbTKPNFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:05:51 -0500
Date: Sun, 16 Nov 2003 14:05:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, reiser@namesys.com,
       herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Kernels was: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031116130558.GB199@elf.ucw.cz>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org> <20031104210310.GA1068@matchmail.com> <20031105004956.19dbd3fb.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105004956.19dbd3fb.skraw@ithnet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There was a bug in one of the released Debian kernels, and do you think this
> > hasn't happened with Redhat, SuSe, or Mandrake?  Just because Debian is
> > completely OSS and maintained mostly by unpaid volunteers, that shouldn't
> > keep them from having a seperate tree like everyone else.
> 
> Just to avoid a false impression: I am in no way against debian project nor do
> I say there is anything specifically bad about it. I am generally disliking
> distros' ideas of having _own_ kernels. Commercial companies like SuSE or Red
> Hat may find arguments for that which are commercially backed, debian on the
> other hand can hardly argue commercially. From the community point of view it
> is just nonsense. It means more work and less useable feedback.
> Bugs is distro kernels are (always) the sole fault of their respective
> maintainers because they actively decided _not_ to follow the mainstream and
> made bogus patches. Why waste the appreciated work of (unpaid) debian
> volunteers in this area? There are tons of other work left with far more
> relevance for users than bleeding edge kernel patches...


Debian is distibution; distributions are _expected_ to fix bugs (etc)
in their packages.

If distribution had all packages unmodified, it would be useless...

So I'd expect all distros to have at least some changes in their
kernel... the same way I expect distros to have some patches in
midnight commander etc.

Of course it is good to keep the .diff as small as possible.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
