Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278464AbRJ3V4d>; Tue, 30 Oct 2001 16:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278429AbRJ3V4Q>; Tue, 30 Oct 2001 16:56:16 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:4480 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S278410AbRJ3V4H>;
	Tue, 30 Oct 2001 16:56:07 -0500
Date: Tue, 30 Oct 2001 13:56:42 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre4 tainted + preempt oops...
Message-ID: <20011030135641.A959@netnation.com>
In-Reply-To: <200110301018.LAA17404@lambik.cc.kuleuven.ac.be> <9rmqkd$bn9$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9rmqkd$bn9$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 06:13:33PM +0000, Linus Torvalds wrote:

> Don't bother, just get pre5. It's a bug in pre4, no blame on vmware or
> even nVidia.

Any known memory-related or queueing-related bugs that would cause Oopses
in SMP 2.4.12?  We've had a few recently-upgraded servers Oopsing
strangely today.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
