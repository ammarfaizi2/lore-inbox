Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261948AbSI3HZl>; Mon, 30 Sep 2002 03:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbSI3HZl>; Mon, 30 Sep 2002 03:25:41 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:31237 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261948AbSI3HZl>; Mon, 30 Sep 2002 03:25:41 -0400
Date: Mon, 30 Sep 2002 09:31:03 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020930073103.GD17884@louise.pinerecords.com>
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de> <1033311400.13001.5.camel@irongate.swansea.linux.org.uk> <20020929153817.GC1014@suse.de> <20020929215204.GG12928@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020929215204.GG12928@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > SCSI drivers can be a real problem. Not the porting of them, most of
> > that is _trivial_ and can be done as we enter 3.0-pre and people show up
> > running that on hardware that actually needs to be ported. The worst bit
> > is error handling, this I view as the only problem.
> 
> And a long-standing one. This should have been fixed in 2.2, it has not
> been fixed in 2.4, it's much desired for 2.6 -- and people are going to
> point away from Linux (and expect Jörg Schilling speaking up again
> should 2.6 be released with what he considers broken API -- I cannot
> tell if all his items are right, but if a third of what he says is true,
> Linux SCSI is not in good shape).

As long as most of that bloke's argumentation strips down to "you don't do
it like everyone else [solaris/irix/whatever] implies you're bound to suck,"
nobody with a bit of sense is going to take him seriously regardless of how
much blah blah he posts on l-k.

T.
