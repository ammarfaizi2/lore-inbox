Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271885AbRH1TOW>; Tue, 28 Aug 2001 15:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271886AbRH1TOM>; Tue, 28 Aug 2001 15:14:12 -0400
Received: from ns.suse.de ([213.95.15.193]:32266 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271885AbRH1TOC>;
	Tue, 28 Aug 2001 15:14:02 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010828180108Z16193-32383+2058@humbolt.nl.linux.org.suse.lists.linux.kernel> <Pine.LNX.4.33.0108281110540.8754-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2001 21:14:15 +0200
In-Reply-To: Linus Torvalds's message of "28 Aug 2001 20:25:12 +0200"
Message-ID: <oup8zg4j8u0.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

Regarding kswapd in 2.4.9:

At least something seems to be broken in it. I did run some 900MB processes
on a 512MB machine with 2.4.9 and kswapd took between 70 and 90% of the CPU
time.

-Andi

