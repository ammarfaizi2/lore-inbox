Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275749AbRI1B1O>; Thu, 27 Sep 2001 21:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275730AbRI1B1E>; Thu, 27 Sep 2001 21:27:04 -0400
Received: from [195.223.140.107] ([195.223.140.107]:253 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275726AbRI1B0y>;
	Thu, 27 Sep 2001 21:26:54 -0400
Date: Fri, 28 Sep 2001 03:26:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Macaulay <robert_macaulay@dell.com>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9-ac14/15(+stuff)]
Message-ID: <20010928032655.H14277@athlon.random>
In-Reply-To: <20010928013730.Y14277@athlon.random> <Pine.LNX.4.33L.0109272050570.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109272050570.19147-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Thu, Sep 27, 2001 at 08:51:42PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 08:51:42PM -0300, Rik van Riel wrote:
> On Fri, 28 Sep 2001, Andrea Arcangeli wrote:
> 
> > well this approch is much less finegrined...
> 
> I'd consider that a feature. Undocumented subtle stuff
> tends to break within 6 months, sometimes even due to
> changes made by the same person who did the original
> subtle trick.

by the same argument we could drop the NOHIGHIO logic in first place.

Andrea
