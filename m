Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSFJTOj>; Mon, 10 Jun 2002 15:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315860AbSFJTOi>; Mon, 10 Jun 2002 15:14:38 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:33474 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S315805AbSFJTOh>; Mon, 10 Jun 2002 15:14:37 -0400
Date: Mon, 10 Jun 2002 21:14:35 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Roland Dreier <roland@topspin.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <52lm9n7y07.fsf@topspin.com>
Message-ID: <Pine.GSO.4.05.10206102114030.17299-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks roland ...

On 10 Jun 2002, Roland Dreier wrote:

> >>>>> "Thomas" == Thomas Mirlacher <Thomas> writes:
> 
>     Thomas> and what about C99 style named initializers for structs?
> 
>     Thomas> struct blah = { .open = driver_open };
> 
> C99 named initializers were already supported at least as early as gcc
> 2.95.2

good. which means we can switch over to those for future patches.

	tm

-- 
in some way i do, and in some way i don't.

