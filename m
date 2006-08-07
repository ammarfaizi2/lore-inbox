Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWHHMuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWHHMuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWHHMtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:49:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32007 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964848AbWHHMtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:49:51 -0400
Date: Mon, 7 Aug 2006 22:00:36 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Masover <ninja@slaphack.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view"	expressed by kernelnewbies.org regarding reiser4 inclusion)
Message-ID: <20060807220035.GB4540@ucw.cz>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com> <44CA8771.1040708@slaphack.com> <44CABB87.3050509@namesys.com> <1154164364.2903.10.camel@laptopd505.fenrus.org> <44CBA4BF.80301@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CBA4BF.80301@slaphack.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Most users not only cannot patch a kernel, they don't know what a patch
> >> is.  It most certainly does. 
> > 
> > 
> > obviously you can provide complete kernels, including precompiled ones.
> > Most distros have a yum or apt or similar tool to suck down packages,
> > it's trivial for users to add a site to that, so you could provide
> > packages if you want and make it easy for them.
> 
> What's more, many distros patch their kernels extensively.  They listen
> to their users, too.  So if there are a lot of users wanting this to be
> in the kernel, let them complain -- loudly -- to their distro to patch
> for Reiser4.

This is not true any more. SUSE (and RedHat) really try not to add
patches to their kernels unless patch is obvious bugfix or merged to
some later mainline. Yeah, we do exceptions, but getting exception is
*way* harder than it used to be.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
