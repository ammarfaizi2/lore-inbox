Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282194AbRKWSBX>; Fri, 23 Nov 2001 13:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282196AbRKWSBN>; Fri, 23 Nov 2001 13:01:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50190 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282194AbRKWSBF>; Fri, 23 Nov 2001 13:01:05 -0500
Date: Fri, 23 Nov 2001 09:55:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Tassonis <timtas@cubic.ch>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15-greased-turkey ???
In-Reply-To: <E167C3O-00028a-00@lttit>
Message-ID: <Pine.LNX.4.33.0111230953240.1294-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Nov 2001, Tim Tassonis wrote:
>
> linux/include/linux/version.h in 2.4.15:
>
> #define UTS_RELEASE "2.4.15-greased-turkey"
> #define LINUX_VERSION_CODE 132111
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
>
> What's this all about??

It'sa worthy follow-up to the 2.2.x "greased weasel" releases, but as
yesterday was Thanksgiving here in the US, and a lot of turkeys offered
their lives in celebration of the new 2.5.0 tree, the 2.4.x series got
christened a "greased turkey" instead of a weasel.

It may not have quite the same connotations of slippery speed as the
weasel, but then some people said the same thing about the penguin too.

		Linus

