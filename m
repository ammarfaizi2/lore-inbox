Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUAVIbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUAVIbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:31:43 -0500
Received: from pdbn-d9bb9e99.pool.mediaWays.net ([217.187.158.153]:11784 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S266014AbUAVIaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:30:00 -0500
Date: Thu, 22 Jan 2004 09:29:50 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Bart Samwel <bart@samwel.tk>, Timothy Miller <miller@techsource.com>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Message-ID: <20040122082950.GA7249@citd.de>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk> <20040120192114.GA30755@citd.de> <20040122001259.GA300@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122001259.GA300@elf.ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 01:12:59AM +0100, Pavel Machek wrote:
> Hi!
> 
> > There is one fundemental braino in the discussion.
> > 
> > Only HALF the bits are for preventing "accidental" collisions. (The
> > "birthday" thing). The rest is for preventing to "brute force" an input
> > that produces the same MD5.(*)
> > 
> > So MD5 has only 2**64 Bits against accidental collsions
> > Btw. I already had (a/the) MD5 collision(*2) in my life.
> > 
> > So you'd need SHA256 or SHA512 to be "really sure(tm)".
> > 
> > 
> > 
> > *: AFAIR i read this in the specs of SHA1 (160 bits). So i guess this is
> > also true for MD5.
> > 
> > *2: I had a direcory of about 1,5 Million images and "md5sum"med them to
> > eliminate doubles. The Log-file, at one point, had the same md5sum as
> > one of the pictures.
> 
> Do you have a copy? I believe *many* people would like to see that
> one.

Unfortunatly not, and reconstruction is impossibel(tm). "Back then(more
than half a year ago)" i didn't see that as important.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

