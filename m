Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUAVANN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbUAVANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:13:13 -0500
Received: from gprs148-45.eurotel.cz ([160.218.148.45]:13440 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266140AbUAVANM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:13:12 -0500
Date: Thu, 22 Jan 2004 01:12:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Bart Samwel <bart@samwel.tk>, Timothy Miller <miller@techsource.com>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Message-ID: <20040122001259.GA300@elf.ucw.cz>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk> <20040120192114.GA30755@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120192114.GA30755@citd.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There is one fundemental braino in the discussion.
> 
> Only HALF the bits are for preventing "accidental" collisions. (The
> "birthday" thing). The rest is for preventing to "brute force" an input
> that produces the same MD5.(*)
> 
> So MD5 has only 2**64 Bits against accidental collsions
> Btw. I already had (a/the) MD5 collision(*2) in my life.
> 
> So you'd need SHA256 or SHA512 to be "really sure(tm)".
> 
> 
> 
> *: AFAIR i read this in the specs of SHA1 (160 bits). So i guess this is
> also true for MD5.
> 
> *2: I had a direcory of about 1,5 Million images and "md5sum"med them to
> eliminate doubles. The Log-file, at one point, had the same md5sum as
> one of the pictures.

Do you have a copy? I believe *many* people would like to see that
one.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
