Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUJJCkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUJJCkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUJJCkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:40:37 -0400
Received: from web13727.mail.yahoo.com ([66.163.176.66]:12691 "HELO
	web13727.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268076AbUJJCke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:40:34 -0400
Message-ID: <20041010024034.60520.qmail@web13727.mail.yahoo.com>
Date: Sat, 9 Oct 2004 19:40:34 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       mkrikis@yahoo.com
In-Reply-To: <58cb370e041009190678aa4c87@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> We SHOULD be discouraging new people from
> contributing to DEPRECATED kernel series.

But 2.4 wasn't quite that deprecated when version 0.0.6
of iswraid was announced on Nov 24, 2003. I don't know
the exact 2.6 timeline but ChangeLog-2.6.0 at www.kernel.org
seems to be dated Dec 17, 2003. Yes, perhaps we should
have asked for consideration sooner...

> > Actually, that is not the reason. There is very little
> > dependence on ataraid in iswraid. It would be quite easy
> > to make iswraid a completely standalone driver. It has not
> > been ported to 2.6 primarily because it would not be welcome
> 
> not because user-space solution is superior?

Like you said, superior from a maintenance point of view.
The users might choose a different measure for superiority.
The coder doing the work may choose yet another way of
deciding which way to proceed. For example, if time was all
that mattered, I think, it would be faster for me to just make
an iswraid port to 2.6 than to try to work with dm+dmraid
which I know very little about, in order to get the same
features supported. But, because I can't speak for my employer,
let me agree with you here and say that yes, I stand corrected,
it is quite possible that it has not been ported because a user
space solution is superior.

> I'm sorry that I dare to not love iswraid... ;-)

You've made your reasons so clear that I don't really mind.

   These opinions are solely mine and
   may not agree with those of my employer.

   Martins Krikis



		

