Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132998AbRDMA6e>; Thu, 12 Apr 2001 20:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133083AbRDMA6Y>; Thu, 12 Apr 2001 20:58:24 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:36114 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132998AbRDMA6Q>; Thu, 12 Apr 2001 20:58:16 -0400
Date: Thu, 12 Apr 2001 20:57:40 -0400 (EDT)
From: Jon Eisenstein <jeisen@mindspring.com>
Reply-To: jeisen@mindspring.com
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: Random paging request errors
In-Reply-To: <Pine.LNX.4.21.0104112246320.25737-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104122056080.439-100000@dominia.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (2) Every so often, I get a non-fatal error on my screen about a
> > kernel paging request error.
> 
> If it's usually the same address, we're probably dealing with
> a kernel bug. If you always get different addresses, chances
> are your RAM is broken (you can test this with memtest86).

I tested with memtest86, and luckily found no problems (and good, because
this RAM is new!).
 
> Decoding the oops is always useful, especially if you can find
> a pattern after you've decoded a few. And if you don't manage
> to find any pattern in them, you know the suspicion lies with
> the hardware ...

I decoded the oops, from /var/log/messages, but I'm not sure how to read
it. Do you have any pointers? Where should I be looking for patterns? Do I
just wait until the next time it happens, get a second log, and diff them?
> 


