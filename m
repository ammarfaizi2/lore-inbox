Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSGTU5B>; Sat, 20 Jul 2002 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGTU5B>; Sat, 20 Jul 2002 16:57:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8201 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317500AbSGTU5B>; Sat, 20 Jul 2002 16:57:01 -0400
Date: Sat, 20 Jul 2002 14:00:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Robert Love <rml@tech9.net>,
       <akpm@zip.com.au>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] for_each_pgdat
In-Reply-To: <20020720205454.GF1096@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0207201359350.1576-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jul 2002, William Lee Irwin III wrote:
>
> Another option would be to convert pgdats to using list.h [ .. ]

Ok guys, you three (and whoever else wants to play? ;) fight it out amonst
yourselves, I'll wait for the end result (iow: I'll just ignore both
patches for now).

		Linus

