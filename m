Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBTAdW>; Mon, 19 Feb 2001 19:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRBTAdL>; Mon, 19 Feb 2001 19:33:11 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:63503 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129098AbRBTAdJ>; Mon, 19 Feb 2001 19:33:09 -0500
Date: Tue, 20 Feb 2001 11:31:52 +1100
From: CaT <cat@zip.com.au>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org, Dragan Stancevic <visitor@valinux.com>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010220113152.G365@zip.com.au>
In-Reply-To: <20010219144935.D21425@saw.sw.com.sg> <200102200018.f1K0IeC32394@moisil.dev.hydraweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102200018.f1K0IeC32394@moisil.dev.hydraweb.com>; from ionut@moisil.cs.columbia.edu on Mon, Feb 19, 2001 at 04:18:40PM -0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 04:18:40PM -0800, Ion Badulescu wrote:
> > In my experiments wait_for_cmd timeouts almost always were related to
> > DumpStats command.
> > I think, we need to investigate what time constraints are related to this
> > command.
> 
> Nothing documented...
> 
> CaT, can you apply this debugging patch and let us know what you get in the
> logs? It should allow us to pinpoint the error a bit more precisely.

patched, old removed, new installed, waiting for fubar. :)

still with 2.2.18

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

