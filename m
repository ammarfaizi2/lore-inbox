Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRBLWYS>; Mon, 12 Feb 2001 17:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129555AbRBLWYI>; Mon, 12 Feb 2001 17:24:08 -0500
Received: from viper.haque.net ([64.0.249.226]:19079 "EHLO viper.haque.net")
	by vger.kernel.org with ESMTP id <S129289AbRBLWYD>;
	Mon, 12 Feb 2001 17:24:03 -0500
Date: Mon, 12 Feb 2001 17:23:37 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <matti.aarnio@zmailer.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lkml subject line
In-Reply-To: <7vh2Hebmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.32.0102121722120.5225-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or you could just check Sender which is already there.

On 12 Feb 2001, Kai Henningsen wrote:

>
> Indeed. What a bad idea that would be.
>
> >   If you want to pre-filter messages traveling thru  linux-kernel  list,
> >   all you need to do is to check the content of   Return-Path:  header.
>
> On the other hand, that's also not a very good scheme. There *is* a good
> way to do this, and it would be really nice if vger could be taught to do
> it: add a List-Id: header (draft-chandhok-listid-04.txt RFC-to-be,
> implemented in lots of mailing list managers already).
>
> Examples from that doc:
>
>     List-Id: List Header Mailing List <list-header.nisto.com>
>     List-Id: <commonspace-users.list-id.within.com>
>     List-Id: "Lena's Personal Joke List"
>              <lenas-jokes.da39efc25c530ad145d41b86f7420c3b.021999.localhost>
>     List-Id: "An internal CMU List" <0Jks9449.list-id.cmu.edu>
>     List-Id: <da39efc25c530ad145d41b86f7420c3b.052000.localhost>
>
> >   Or perhaps my utter aborrence is due to the way how GNU MAILMAN handles
> >   that tagging (badly, that is).
>
> Mailman, incidentally, _has_ List-Id: support.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
