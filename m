Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269772AbRHDDXq>; Fri, 3 Aug 2001 23:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269773AbRHDDXg>; Fri, 3 Aug 2001 23:23:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24079 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269772AbRHDDXY>;
	Fri, 3 Aug 2001 23:23:24 -0400
Date: Sat, 4 Aug 2001 00:23:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, Ben LaHaise <bcrl@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032003200.15155-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108040022110.2526-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:

> Please just remove the code instead. I don't think it buys you anything.

IIRC you applied the patch introducing that logic because it
gave a 25% performance increase under some write intensive
loads (or something like that).

Or are you telling us now that there wasn't a reason at all
you applied that code to your tree in the first place? ;))

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

