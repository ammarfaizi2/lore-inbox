Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313706AbSDPO5M>; Tue, 16 Apr 2002 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313712AbSDPO5L>; Tue, 16 Apr 2002 10:57:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47371 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313706AbSDPO5K>;
	Tue, 16 Apr 2002 10:57:10 -0400
Date: Tue, 16 Apr 2002 11:56:50 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.44.0204160948130.3933-100000@waste.org>
Message-ID: <Pine.LNX.4.44L.0204161156330.1960-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Oliver Xymoron wrote:
> On Mon, 15 Apr 2002, Linus Torvalds wrote:
> > On Mon, 15 Apr 2002, Linus Torvalds wrote:
> > >
> > > Which requires the user to use something like
> > >
> > > 	for_each_zone(zone) {
> > > 		...
> > > 	} end_zone;

> Ugh. If we're going to use such ugly things, it would be nice if they were
> do_zone/while_zone instead of being suggestive of a for loop.

Ummm, it _is_ a for loop.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

