Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131238AbRCGXf7>; Wed, 7 Mar 2001 18:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131239AbRCGXfu>; Wed, 7 Mar 2001 18:35:50 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:23049 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131238AbRCGXfc>; Wed, 7 Mar 2001 18:35:32 -0500
Message-Id: <200103072335.f27NZ4O32555@aslan.scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx 
In-Reply-To: Your message of "Wed, 07 Mar 2001 17:56:51 EST."
             <3AA6BCB3.F74C4ED7@mandrakesoft.com> 
Date: Wed, 07 Mar 2001 16:35:04 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>hmmm..  Is there a reason why this would be -needed-?  It wouldn't be
>hard to implement, but I would rather not have drivers dealing with a
>list whose normal state is defined as "mostly sorted"...

That's the wrong definition.  The list is "sorted by probe order".

--
Justin
