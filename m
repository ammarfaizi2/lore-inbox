Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274074AbRISObi>; Wed, 19 Sep 2001 10:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274076AbRISObS>; Wed, 19 Sep 2001 10:31:18 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:8363 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S274074AbRISObN>; Wed, 19 Sep 2001 10:31:13 -0400
Date: Wed, 19 Sep 2001 17:31:36 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <20010919154701.A7381@stud.ntnu.no>
Message-ID: <Pine.GSO.4.21.0109191707260.23205-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Think again.

It seems to fix the stability problem. We don;t know why, but
experimetation shows that those _with_ the problem are relieved. This is
fine! We are happy with it.

We write to a register marked as "don't write" by Via. This is potentialy 
dangerous in ways we don't know yet.


> If this should be an optional fix, it should be default enabled, and then
> all those who don't want to use the fix, should disable it. But I guess, as
> long as it's an option, someone is _bound_ to come naging with their
> problems...

How can you know you need it if it is enabled by default. I see many more
ppl just not being bothered enough to check. 

And then, would you prefer having somebody naging about, say, his
northbirdge melting down after 10mins with K7 optimizations enabled?

-K.


