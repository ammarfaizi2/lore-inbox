Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275727AbRI1BWe>; Thu, 27 Sep 2001 21:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275730AbRI1BWZ>; Thu, 27 Sep 2001 21:22:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44042 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S275727AbRI1BWO>;
	Thu, 27 Sep 2001 21:22:14 -0400
Date: Thu, 27 Sep 2001 20:51:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Macaulay <robert_macaulay@dell.com>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
 2.4.9-ac14/15(+stuff)]
In-Reply-To: <20010928013730.Y14277@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109272050570.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2001, Andrea Arcangeli wrote:

> well this approch is much less finegrined...

I'd consider that a feature. Undocumented subtle stuff
tends to break within 6 months, sometimes even due to
changes made by the same person who did the original
subtle trick.

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

