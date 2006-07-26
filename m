Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWGZN2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWGZN2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWGZN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:28:49 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:25543
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1750718AbWGZN2t (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 26 Jul 2006 09:28:49 -0400
Date: Wed, 26 Jul 2006 15:29:57 +0200
From: andrea@cpushare.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726132957.GH32243@opteron.random>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <200607230920.04129.rene@exactcode.de> <17604.31639.213450.987415@gargle.gargle.HOWL> <20060725123558.GA32243@opteron.random> <44C65931.6030207@namesys.com> <20060726124557.GB23701@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726124557.GB23701@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 02:45:57PM +0200, Adrian Bunk wrote:
> On Tue, Jul 25, 2006 at 11:47:29AM -0600, Hans Reiser wrote:
> 
> > Wow, I would never have guessed our market share was that high as 1/5th
> > of ext3.  I mean, you can't even get a distro which allows you to
> > install onto reiser4 without hours of work so far as I know.  I guess
> > there are people who really do care about twice as fast.
> 
> I doubt Andreas values have much value.

I think nobody ever pretended them to have much value, they only need
to have some minor value to be useful. And as far as I can tell no
better source of data about the kernel testing userbase exists as of
today.

> According to the numbers on the klive website, Gentoo has 47 times as 
> many users as SuSE (sic).
> 
> Considering that klive is offered by someone working for SuSE, the 
> Gentoo project could make a good news article ("Numbers by a SuSE 
> developer confirm Gentoo has 47 times the market share of Suse.")
> out of it.  ;-)

Oh well, you misunderstood KLive completely. Please read again the top
of the page: "this project aims to provide kernel live feedback about
the usage of every different Linux Kernel version". Where did I ever
mention anything about distributions?

There's absolutely no way to tell which distribution is running. I
only can tell which _kernel_ is running. It could be 100% of the
mainline users are running mainline on top of SUSE distro, or on top
of Gentoo, or on top of Ubuntuu, there's absolutely no way to know
about the distro. Nobody could ever make a claim like the above by
using the KLive data.

To make an example I run mainline myself on top of opensuse 10.1, and
I get rightfully accounted as a "mainline" and not as a "SUSE".

All you can tell is that there are many more people running KLive in
combination with Gentoo kernels than with SUSE kernels. But you can't
tell anything about what kind of distribution is running. One could
guess the Gentoo kernels run on top of a Gentoo userland, but for the
mainline ones you really can't tell, they could be slackware but they
could be any other distro too.

Also note that the cpushare.com domain is not related to any distro,
so the fact I also do consulting for SUSE is irrelevant to KLive or
any other dealings at the cpushare.com domain. As long there is people
running KLive and browsing the website like now, it means somebody
thinks it's useful and so I keep delivering the service.

As of now, the Gentoo and mainline kernel users are the ones providing
most of the feedback.

Perhaps I should have filed a patent on KLive too just to make you
happy, right?
