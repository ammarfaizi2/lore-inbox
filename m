Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbTCHCHt>; Fri, 7 Mar 2003 21:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCHCHs>; Fri, 7 Mar 2003 21:07:48 -0500
Received: from almesberger.net ([63.105.73.239]:16389 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S261997AbTCHCHq>; Fri, 7 Mar 2003 21:07:46 -0500
Date: Fri, 7 Mar 2003 23:18:11 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Dan Kegel <dank@kegel.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Those ruddy punctuation fixes
Message-ID: <20030307231811.T2791@almesberger.net>
References: <3E684737.7080704@kegel.com> <20030307121723.B3204@redhat.com> <1047078959.23697.12.camel@irongate.swansea.linux.org.uk> <20030308005241.GA24077@suse.de> <20030307212925.S2791@almesberger.net> <3E6942C9.1040204@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6942C9.1040204@kegel.com>; from dank@kegel.com on Fri, Mar 07, 2003 at 05:09:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> The next best thing might be for the spelling police
> to maintain an archive of all the accepted spellfix patches.

At the end of the day, bulk fixes may just be the least evil.

Alternatives like passing all spelling fixes individually through
the appropriate channels for each subsystem would still cause
conflicts, and also burden Linus with lots of re-iterations of
the same theme, coming from many directions and spread over weeks.

A bit of coordination would be useful, though. E.g. I suppose it
would hurt people like Dave Jones (with his 2.4 patch queue) a lot
less if the spelling changes would happen while their queue is
reasonably short.

> This spellfix business is way more work than is reasonable.

It will be easier the next time ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
