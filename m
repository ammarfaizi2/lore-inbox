Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315598AbSECIdu>; Fri, 3 May 2002 04:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315601AbSECIds>; Fri, 3 May 2002 04:33:48 -0400
Received: from epic7.Stanford.EDU ([171.64.15.40]:48300 "EHLO
	epic7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S315598AbSECIds>; Fri, 3 May 2002 04:33:48 -0400
Date: Fri, 3 May 2002 01:33:34 -0700 (PDT)
From: Vikram <vvikram@stanford.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20020502225743.GC22246@elf.ucw.cz>
Message-ID: <Pine.GSO.4.44.0205030131470.11340-100000@epic7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What is ccache?

maybe this?

<snip>
ccache is a compiler cache. It acts as a caching pre-processor to C/C++
compilers, using the -E compiler switch and a hash to detect when a
compilation can be satisfied from cache. This often results in a 5 to 10
times speedup in common compilations
</snip>

http://ccache.samba.org/

			Vikram


Pavel > --
> (about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
> no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


