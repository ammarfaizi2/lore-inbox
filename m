Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317503AbSGTUtz>; Sat, 20 Jul 2002 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSGTUtz>; Sat, 20 Jul 2002 16:49:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317503AbSGTUty>; Sat, 20 Jul 2002 16:49:54 -0400
Date: Sat, 20 Jul 2002 13:53:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Ed Tomlinson <tomlins@cam.org>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
In-Reply-To: <Pine.LNX.4.44L.0207201740580.12241-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0207201351160.1552-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jul 2002, Rik van Riel wrote:
>
> OK, I'll try to forward-port Ed's code to do that from 2.4 to 2.5
> this weekend...

Side note: while I absolutely think that is the right thing to do, that's
also the much more "interesting" change. As a result, I'd be happier if it
went through channels (ie probably Andrew) and had some wider testing
first at least in the form of a CFT on linux-kernel.

[ Or has it already been in 2.4.x in any major tree? (In which case my
  testing argument is lessened to some degree and it's mainly just to
  verify that the forward-port works). ]

Thanks,
		Linus

