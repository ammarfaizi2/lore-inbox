Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281191AbRKYW5W>; Sun, 25 Nov 2001 17:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281193AbRKYW5R>; Sun, 25 Nov 2001 17:57:17 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:29328 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281191AbRKYW5I>;
	Sun, 25 Nov 2001 17:57:08 -0500
Message-ID: <3C017740.FB17CD8C@pobox.com>
Date: Sun, 25 Nov 2001 14:57:04 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick McFarland <unknown@panax.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.21.0111241744250.12119-100000@freak.distro.conectiva> <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com> <20011124205632.C241@localhost> <20011124211204.D241@localhost> <3C0058CF.D97D0E2B@starband.net> <20011124214114.E241@localhost> <3C006F44.201DC73F@pobox.com> <20011125165819.G238@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McFarland wrote:

> So your saying I should actually trust my distro to build a kernel right?

Depends on how paranoid you are - I find the
red hat kernels to be a safe, if boring choice.

> I build my own kernels, I have since day one.

Sounds like you would have done better to use
the vendor suppplied kernel in this case -

> But, heres a semi-key point, what happens to vendor patches? Do they ever get folded back into the main tree?

Many do, some don't.

Actual bug fixes get folded into the main tree,
but things like the e100 driver, the dell perc
raid drivers, the tux webserver, the linux
vertual server etc that are all in the red hat
kernel may never be in mainstream.

I would sure like to see tux in main kernel,
since it's superior to the khttpd that's part
of the mainline tree.

But things like the e100 driver I could live
without if eepro100 gets to the point where
it works just as well.

cu

jjs


