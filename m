Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSERG2u>; Sat, 18 May 2002 02:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSERG2t>; Sat, 18 May 2002 02:28:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290289AbSERG2s>; Sat, 18 May 2002 02:28:48 -0400
Date: Fri, 17 May 2002 23:28:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ghozlane Toumi <ghoz@sympatico.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: <3CE54EE0.70FB57E9@zip.com.au>
Message-ID: <Pine.LNX.4.44.0205172327330.932-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 17 May 2002, Andrew Morton wrote:
>
> Almost..  The final solution to all problems is to merge
> kbuild-2.5 and then to teach it to use relative pathnames
> when performing a build within the source tree.  Presumably
> that's not hard, but I'm surely about to learn why it's
> not feasible.

I'm hoping we can get there in small steps, rather than a big traumatic
merge. I'd love to just try to merge it piecemeal.

Especially as I don't find the existign system so broken.

		Linus

