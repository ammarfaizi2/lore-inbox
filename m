Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRC3Rg3>; Fri, 30 Mar 2001 12:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRC3RgT>; Fri, 30 Mar 2001 12:36:19 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:31301 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S131578AbRC3RgH>; Fri, 30 Mar 2001 12:36:07 -0500
Date: Fri, 30 Mar 2001 11:35:12 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, George Bonser <george@gator.com>,
   linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.3 aic7xxx wont compile
In-Reply-To: <200103301509.f2UF9ws23721@aslan.scsiguy.com>
Message-ID: <Pine.LNX.3.96.1010330113142.8826Q-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, Justin T. Gibbs wrote:
> >  Yes,  "-I." from gcc flags.
> >
> >  The sad part is that people have been patching right and left to get
> >  that monster utility to compile because the dependencies say that it
> >  must be used to remake the AIC sequencer binary image; which image is
> >  perfectly ok except of its timestampts due to patching process.
> 
> The sad part is that there has been a fix for this "problem", supplied
> by the author of the driver, for well over a month that everyone seems
> to ignore.

You cannot expect that all people will instantly start using the
latest driver from your Web site, immediately.  Especially considering

1) There is no MAINTAINERS entry listing you or your web site
2) Your e-mail address is nowhere to be found in the code
3) The driver Web site address is nowhere to be found in the code
4) People are used to getting aic7xxx out of the kernel tarball

Are people just supposed to pick up your psychic waves?  :)

	Jeff




