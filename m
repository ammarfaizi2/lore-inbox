Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264731AbRFQNKZ>; Sun, 17 Jun 2001 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264732AbRFQNKQ>; Sun, 17 Jun 2001 09:10:16 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:35600 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S264731AbRFQNKE>; Sun, 17 Jun 2001 09:10:04 -0400
To: linux-kernel@vger.kernel.org
Cc: rbultje@ronald.bitfreak.net
Subject: Re: a memory-related problem?
In-Reply-To: <9gi848$pb2$1@ns1.clouddancer.com>
In-Reply-To: <CDEJIPDFCLGDNEHGCAJPOEFGCCAA.rbultje@ronald.bitfreak.net> <9gi848$pb2$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010617131002.EF84D784BD@mail.clouddancer.com>
Date: Sun, 17 Jun 2001 06:10:02 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Hi,
>
>I just added 128 MB of RAM to my machine which already had 128 MB and
>which has 128 MB swap. 128 MB RAM + 128 MB swap (either the new or the
>old 128 MB RAM) works, but the combination of that, 256 MB RAM + 128 MB
>swap, crashes the compu during startup with either an "unresolved-
>symbols in init" message (which is completely random, each boot shows
>different unresolved references) or with oopses right after starting
>init.

It's more likely that the two RAM sticks differ.  I had a similar
problem in a Windoze machine awhile ago.  Move one stick of RAM into
another bank, i.e. with 4 memory slots, use #1 and #3.  If you only
have 2 memory slots, return/sell what you have and buy 2 sticks at the
same time.


--My pid is Inigo Montoya.  You killed -9 my parent process.  Prepare to vi. 
