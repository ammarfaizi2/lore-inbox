Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSHRECJ>; Sun, 18 Aug 2002 00:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSHRECI>; Sun, 18 Aug 2002 00:02:08 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:44523 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S318835AbSHRECI>; Sun, 18 Aug 2002 00:02:08 -0400
Date: Sat, 17 Aug 2002 21:06:08 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Robert Love <rml@tech9.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <1029642713.863.2.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208172104420.21581-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2002, Robert Love wrote:

> [1] this is why I wrote my netdev-random patches.  some machines just
>     have to take the entropy from the network card... there is nothing
>     else.

many southbridges come with audio these days ... isn't it possible to get
randomness off the adc even without anything connected to it?

-dean

