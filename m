Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSFJVth>; Mon, 10 Jun 2002 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSFJVtg>; Mon, 10 Jun 2002 17:49:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38149 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316422AbSFJVte>; Mon, 10 Jun 2002 17:49:34 -0400
Date: Mon, 10 Jun 2002 17:45:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Olivier Galibert <galibert@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: MTU discovery
In-Reply-To: <20020610055049.A30121@melpomene.ncsl.nist.gov>
Message-ID: <Pine.LNX.3.96.1020610174357.23851D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Olivier Galibert wrote:

> On Mon, Jun 10, 2002 at 11:05:13AM +0300, Matti Aarnio wrote:
> >   Some devices do, however, support reception (and transmit) of what
> >   is called "jumbograms".  With boomerang you can set a register
> >   to contain the limit value.  Alternatively with boomerang, and
> >   its predecessors, you can set a bit to accept extra-large frames.
> > 
> >   I recall the ultimate limit is in order of 4kB.
> 
> Actually, in my experience jumbograms are usually 9000 bytes.

To assist in searching for info, I've also seen the terms "jumbo packets"
and "jumbo frames." 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

