Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286517AbRL0Tbl>; Thu, 27 Dec 2001 14:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286519AbRL0Tbb>; Thu, 27 Dec 2001 14:31:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39177 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286517AbRL0TbN>; Thu, 27 Dec 2001 14:31:13 -0500
Date: Thu, 27 Dec 2001 11:29:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33L.0112271713580.12225-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112271126550.1052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Rik van Riel wrote:
>
> Of course the patch will be updated when needed, but I still
> have a few 6-month old patches lying around that still work
> as expected and don't need any change.

Sure. Automatic re-mailing can be part of the maintainership, if the
testing of the validity of the patch is also automated (ie add a automated
note that says that it has been verified).

It's just that I actually _have_ had people who just put "mail torvalds <
crap" in their cron routines. It quickly caused them to become part of my
spam-filter, and thus _nothing_ ever showed up from them, whether
automated or not..

		Linus

