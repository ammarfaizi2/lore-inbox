Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSDOUVf>; Mon, 15 Apr 2002 16:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSDOUVf>; Mon, 15 Apr 2002 16:21:35 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313201AbSDOUVe>;
	Mon, 15 Apr 2002 16:21:34 -0400
Date: Mon, 8 Apr 2002 20:35:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Dominik Kubla <kubla@sciobyte.de>, linux-kernel@vger.kernel.org
Subject: Re: implementing soft-updates
Message-ID: <20020408203515.B540@toy.ucw.cz>
In-Reply-To: <20020409184605.A13621@cecm.usp.br.suse.lists.linux.kernel> <200204100041.g3A0fSj00928@saturn.cs.uml.edu.suse.lists.linux.kernel> <20020410092807.GA4015@duron.intern.kubla.de.suse.lists.linux.kernel> <p73adsbpdaz.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > The background  fsck capability, just  like journalling or  logging, are
> > typically only in needed in 24/7 systems (sure, they are nice to have in
> > your home  system, but do  you _REALLY_ need  them? i don't!)  and those
> > system  typically are  run on  proven  hardware which  is operated  well
> > within the specs. So please don't construct these kinds of arguments.
> 
> You can already do background fsck on a linux system today. Just do it on
> a LVM/EVMS snapshot.

How do you fix errors you find by such background fsck?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

