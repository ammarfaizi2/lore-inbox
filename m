Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbREYXG1>; Fri, 25 May 2001 19:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbREYXGS>; Fri, 25 May 2001 19:06:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28677 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262012AbREYXGE>; Fri, 25 May 2001 19:06:04 -0400
Date: Fri, 25 May 2001 16:05:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105251919480.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251605010.15404-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Rik van Riel wrote:
>
> Yeah, I guess the way Linux 2.2 balances things is way too
> experimental ;)

Ehh.. Take a look at the other differences between the VM's. Which may
make a 2.2.x approach completely bogus.

And take a look at how long the 2.2.x VM took to stabilize, and how
INCREDIBLY BAD some of those kernels were.

		Linus

