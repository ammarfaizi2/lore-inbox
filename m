Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbRG1WqF>; Sat, 28 Jul 2001 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbRG1Wp4>; Sat, 28 Jul 2001 18:45:56 -0400
Received: from pD9E1EFED.dip.t-dialin.net ([217.225.239.237]:59148 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267215AbRG1Wpg>; Sat, 28 Jul 2001 18:45:36 -0400
Date: Sun, 29 Jul 2001 00:45:42 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andre Pang <ozone@algorithm.com.au>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010729004542.A9350@emma1.emma.line.org>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Andre Pang <ozone@algorithm.com.au>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010726174844.W17244@emma1.emma.line.org> <E15PnTJ-0003z0-00@the-village.bc.nu> <9jpftj$356$1@penguin.transmeta.com> <20010726095452.L27780@work.bitmover.com> <996167751.209473.2263.nullmailer@bozar.algorithm.com.au> <3B605A3B.6E95AE36@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B605A3B.6E95AE36@namesys.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Hans Reiser wrote:

> No, Linus is right and the MTA guys are just wrong.  The mailers are
> the place to fix things, not the kernel.  If the mailer guys want to
> depend on the kernel being stupidly designed, tough.  Someone should
> fix their mailer code and then it would run faster on Linux than on
> any other platform.

Well, some systems are even documented that way, so there's nothing with
"depend on the kernel being stupidly designed", but "depend on what
mount(8) says".

MTA authors don't play games, they also write that their software relies
on this behaviour, as laid out.

-- 
Matthias Andree
