Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUGWTdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUGWTdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 15:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUGWTdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 15:33:01 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:35070 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267950AbUGWTcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 15:32:50 -0400
Subject: Re: A users thoughts on the new dev. model
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: barnowl@unix.eng.ua.edu
In-Reply-To: <40FFD760.8060504@unix.eng.ua.edu>
References: <40FFD760.8060504@unix.eng.ua.edu>
Content-Type: text/plain
Message-Id: <1090611158.2931.13.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 23 Jul 2004 12:32:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 08:04, Evan Hisey wrote:

> As an end use of the vanilla 
> tree, I would like to point out that a large number of people and 
> projects rely on the vanilla kernel to be the stable tree do to the 
> overly varied and random patching nature of vendor supplied kernels 

It looks like a communication problem.

Like someone else noted, 2.6 is currently more stable than the
correspondent 2.2 and 2.4 versions, due to efforts by OSDL and others,
and perhaps due to significant contribution from A. Morton, etc.
So, when Andrew says that perhaps 2.6 is not going to be the most stable
series, it does not mean "it's going to be the least stable series among
2.0, 2.2, 2.4, etc." In fact, even taking Andrew's words into account,
it may well be that 2.6 is going to be more stable than 2.4 - the same
2.4 that "clueless" users were happily using on their production
servers, while at the same time complaining about 2.6 being too
"unstable".

It could be that the ones who are complaining have an oversimplified,
"binary" view of how things are:
- Caveman thinks 2.2, 2.4 stable is
- Caveman thinks 2.6 stable is not
Or, in other words, stability seems to be a magical property that's
added or removed to/from a software based on their names/numbers/etc.

While the reality might well be more complex. So, 2.6 is not the most
stable series. That's fine, vanilla "stable" was never the most stable -
that title goes to the Red Hat Enterprise kernels and the like.
But if 2.6 is more stable than 2.4, then by all means that's fine with
me.

It seems to me that some users do not want to just use the most stable
kernel. They want to use the most stable kernel AND that kernel must be
the "stable" vanilla kernel.
Sorry guys, but the vanilla kernel has many goals. Stability is only one
of them.

-- 
Florin Andrei

http://florin.myip.org/

