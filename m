Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbREYXIH>; Fri, 25 May 2001 19:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbREYXHt>; Fri, 25 May 2001 19:07:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30725 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262013AbREYXHf>; Fri, 25 May 2001 19:07:35 -0400
Date: Fri, 25 May 2001 16:07:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105251932380.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251606360.15404-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Rik van Riel wrote:
>
> Without the patch my workstation (with ~180MB RAM) usually has
> between 50 and 80MB of inode/dentry cache and real usable stuff
> gets  swapped out.

All I want is more people giving feedback.

It's clear that neither my nor your machine is a good thing to base things
on.

		Linus

