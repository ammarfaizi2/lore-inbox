Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268888AbTBSFJy>; Wed, 19 Feb 2003 00:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268889AbTBSFJx>; Wed, 19 Feb 2003 00:09:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18182 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268888AbTBSFJw>; Wed, 19 Feb 2003 00:09:52 -0500
Date: Tue, 18 Feb 2003 21:16:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate warnings in generated module files
In-Reply-To: <20030218194351.A23525@twiddle.net>
Message-ID: <Pine.LNX.4.44.0302182115500.1923-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Feb 2003, Richard Henderson wrote:
> > 
> > But hey, my brain is cabbage, and my memory might be crap.
> 
> Hmm.  It was always supposed to have worked, but I suppose
> there could have been bugs.  How far back to I need to go
> looking?

Some people are still using 2.95, I think anything past that is long since 
unsupported and not worth worrying about.

		Linus

