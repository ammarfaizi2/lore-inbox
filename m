Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSGTXpE>; Sat, 20 Jul 2002 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGTXpE>; Sat, 20 Jul 2002 19:45:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46865 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317578AbSGTXo6>; Sat, 20 Jul 2002 19:44:58 -0400
Date: Sat, 20 Jul 2002 16:48:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, <akpm@zip.com.au>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VM strict overcommit
In-Reply-To: <1027212843.16818.59.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207201645400.1901-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Jul 2002, Alan Cox wrote:
>
> The GPL no warranty clauses were added directly to the file because they
> are suppsed to be there.

That's a load of bull. They are _NOT_ supposed to be there.

If you want legal disclaimers etc, do them in files you created and you
own 100%, not in places that others started and work on. Or put them to
the bottom of the file where they aren't in the way.  Or add a "read teh
GPL in the COPYING file", but don't start adding a ton of crap to core
kernel files.

There is no "goodness" in being a lawyer in .c files.

		Linus

