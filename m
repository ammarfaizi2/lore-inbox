Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278658AbRJ3XGE>; Tue, 30 Oct 2001 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278678AbRJ3XF4>; Tue, 30 Oct 2001 18:05:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37646 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278658AbRJ3XFl>; Tue, 30 Oct 2001 18:05:41 -0500
Date: Tue, 30 Oct 2001 15:04:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Simon Kirby <sim@netnation.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre4 tainted + preempt oops...
In-Reply-To: <20011030135641.A959@netnation.com>
Message-ID: <Pine.LNX.4.33.0110301502390.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Simon Kirby wrote:
> On Tue, Oct 30, 2001 at 06:13:33PM +0000, Linus Torvalds wrote:
>
> > Don't bother, just get pre5. It's a bug in pre4, no blame on vmware or
> > even nVidia.
>
> Any known memory-related or queueing-related bugs that would cause Oopses
> in SMP 2.4.12?  We've had a few recently-upgraded servers Oopsing
> strangely today.

Can you send me the oops? 2.4.12 may not be the best kernel ever released,
but I don't think it was fundamentally broken either. Maybe the oops will
remind me about something..

		Linus

