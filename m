Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAHLa1>; Mon, 8 Jan 2001 06:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136566AbRAHLaR>; Mon, 8 Jan 2001 06:30:17 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:10231 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129561AbRAHLaE>; Mon, 8 Jan 2001 06:30:04 -0500
Date: Mon, 8 Jan 2001 12:29:49 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Extraneous whitespace removal?
Message-ID: <20010108122949.D4991@khan.acc.umu.se>
In-Reply-To: <20010108044218.A9610@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010108044218.A9610@foozle.turbogeek.org>; from jmd@foozle.turbogeek.org on Mon, Jan 08, 2001 at 04:42:18AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 04:42:18AM -0600, Jeremy M. Dolan wrote:

[snip]

>  - Yes, I am pretty pedantic to propose a 19M patch that doesn't *DO*
>    anything.

While I really like the idea with this patch, I'm 100% certain that
Linus would not, under any circumstances, accept this patch.

I suggest that we instead force everyone to program with:

syntax on
let c_space_errors=1

(Or equivalent Emacs/[insert favourite editor here]-setting instead)

While at it, force people to read linux/Documentation/CodingStyle
and make them adhere to it.

Of course, I guess this is a free world (yeah, right) and everyone
should have the right to code in their own way, but I'd wish that people
at least could be consistent when indenting/spacing/bracing/whatever,
and when patching other people's code, also follow the already set
standard of that file instead of introducing a new one...


/David Weinehall [yup, I know everyone will hate me for this...]
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
