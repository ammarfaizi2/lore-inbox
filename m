Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRBOUUt>; Thu, 15 Feb 2001 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRBOUU3>; Thu, 15 Feb 2001 15:20:29 -0500
Received: from jalon.able.es ([212.97.163.2]:8586 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129703AbRBOUUT>;
	Thu, 15 Feb 2001 15:20:19 -0500
Date: Thu, 15 Feb 2001 21:20:07 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans
Message-ID: <20010215212007.A995@werewolf.able.es>
In-Reply-To: <85F1402515F13F498EE9FBBC5E07594220AD85@TTGCS.teamtoolz.net> <200102151747.f1FHlDO64938@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200102151747.f1FHlDO64938@aslan.scsiguy.com>; from gibbs@scsiguy.com on Thu, Feb 15, 2001 at 18:47:13 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.15 Justin T. Gibbs wrote:
> >All of my boxes with that card are on 2.2.16. The rest are on 2.4.1, so I
> >don't really have a need to test 2.2.18 as I would rather be on 2.4.x for
> >all of my boxes.
> 
> Well, I'll try and generate patches against 2.2.16 soon.  I probably
> need to support 2.2.14 too.  There are already so many versions to
> keep track of, the sooner the driver becomes embedded, the better.
> 

Please, I think it would be much more useful a patch against the latest
2.2.19-pre (if that one for 2.2.18 does not work, I have not tried)
and the latest 2.4.1-ac14, that is what people experiments with.

People who has still a 2.2.14 or 16 looks like does not worry too much
about updating and building kernels, and it they go into the work, they
can just go to 2.2.18, compatible with 16 and 14 and much more stable.

I think it is better to work for preX kernels than for eldely ones.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac14 #1 SMP Thu Feb 15 16:05:52 CET 2001 i686

