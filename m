Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSFTTns>; Thu, 20 Jun 2002 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSFTTnr>; Thu, 20 Jun 2002 15:43:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315491AbSFTTnq>; Thu, 20 Jun 2002 15:43:46 -0400
Date: Thu, 20 Jun 2002 12:44:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>, <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>, <pekkas@netcore.fi>
Subject: Re: [PATCH] ipv6 statics
In-Reply-To: <20020620155126.1bf955f3.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0206201243220.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Stephen Rothwell wrote:
>
> This patch make some things in the ipv6 code static.

You've got whitespace-disease. Your mailer apparently does word-wrap for
files. Please fix your mailer.

I fixed them by hand this time,

		Linus

