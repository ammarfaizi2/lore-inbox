Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSDWUM4>; Tue, 23 Apr 2002 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSDWUMz>; Tue, 23 Apr 2002 16:12:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:29637 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315337AbSDWUMy>; Tue, 23 Apr 2002 16:12:54 -0400
Date: Tue, 23 Apr 2002 22:09:17 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5 activity by directory
In-Reply-To: <200204231936.g3NJabC29433@work.bitmover.com>
Message-ID: <Pine.NEB.4.44.0204232201520.11258-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Larry McVoy wrote:

> This one shows which directories had deltas over the specified time period.
> Let me know if this is useful and/or if there should be a graphical barchart
> of this sort of thing available.
>
> == Directory activity in the last week ==
>    50  15.02%  include/asm-x86_64
>...

It's a nice statistic and although I'm not sure whether there are "real"
uses of it I'm wondering about what you are counting:

a) changesets (each changeset that touch file(s) below a directory)
b) number of changed files (files touched by one or more changesets)
c) each change to one file is counted

?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




