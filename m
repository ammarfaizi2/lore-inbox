Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130513AbRBKAYW>; Sat, 10 Feb 2001 19:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbRBKAYM>; Sat, 10 Feb 2001 19:24:12 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12292 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130513AbRBKAXv>; Sat, 10 Feb 2001 19:23:51 -0500
Date: Sat, 10 Feb 2001 20:33:29 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-mm@kvack.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.0-ac8/9  page_launder() fix
In-Reply-To: <Pine.LNX.4.21.0102102051450.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0102102027250.27734-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tested it here and it seems to behave pretty well. 

On Sat, 10 Feb 2001, Rik van Riel wrote:

> Hi,
> 
> the patch below should make page_launder() more well-behaved
> than it is in -ac8 and -ac9 ... note, however, that this thing
> is still completely untested and only in theory makes page_launder
> behave better ;)
> 
> Since there seems to be a lot of VM testing going on at the
> moment I thought I might as well send it out now so I can get
> some feedback before I get into the airplane towards sweden
> tomorrow...
> 
> cheers,
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
