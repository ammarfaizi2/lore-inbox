Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBNLpW>; Wed, 14 Feb 2001 06:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131831AbRBNLpM>; Wed, 14 Feb 2001 06:45:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39947 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129112AbRBNLpI>; Wed, 14 Feb 2001 06:45:08 -0500
To: linux-kernel@vger.kernel.org
From: Daniel Quinlan <quinlan@transmeta.com>
Subject: Re: setting cpu speed on crusoe
Date: 14 Feb 2001 03:44:37 -0800
Organization: Transmeta Corporation
Message-ID: <6y66idbiai.fsf@magnesium.transmeta.com>
In-Reply-To: <20010210224855.D7877@bug.ucw.cz> <Pine.LNX.4.10.10102130928490.29787-100000@penguin.transmeta.com>
X-Trace: palladium.transmeta.com 982151077 2702 127.0.0.1 (14 Feb 2001 11:44:37 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 14 Feb 2001 11:44:37 GMT
Original-Sender: quinlan@transmeta.com
X-Newsreader: Gnus v5.7/Emacs 20.4
Cache-Post-Path: palladium.transmeta.com!unknown@magnesium.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> We're going through our docs and we have internal programs that we'll
> release for this so that you'll not just have docs but actually working
> code too. It just needs to be cleaned up a bit, and go through the proper
> channels (ever wonder why open source gets deveoped faster?). It really
> should be "any day now".

Working code is better anyway (and in this case, it's first).  Go to
your favorite kernel.org mirror and check out

  /pub/linux/utils/cpu/crusoe/longrun-0.9.tar.gz

It does everything you could ever want and more, as long as you include
the CPUID and MSR devices in your kernel, set up the devices correctly,
etc.

Dan
