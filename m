Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbUAVIva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAVIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:51:30 -0500
Received: from pdbn-d9bb9e99.pool.mediaWays.net ([217.187.158.153]:13320 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S266132AbUAVIv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:51:29 -0500
Date: Thu, 22 Jan 2004 09:51:23 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Bart Samwel <bart@samwel.tk>, Timothy Miller <miller@techsource.com>,
       Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating money to OSDL
Message-ID: <20040122085123.GB7249@citd.de>
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu> <4008509B.2060707@techsource.com> <200401171415.31645.bart@samwel.tk> <20040120192114.GA30755@citd.de> <20040122023609.GB4392@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122023609.GB4392@mail.shareable.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 02:36:09AM +0000, Jamie Lokier wrote:
> Matthias Schniedermeyer wrote:
> > *2: I had a direcory of about 1,5 Million images and "md5sum"med them to
> > eliminate doubles. The Log-file, at one point, had the same md5sum as
> > one of the pictures.
> 
> Something similar happened to me once.  Two different files with the
> same result from md5sum.
> 
> When I ran md5sum again, it still reported the same results.
> 
> Then when I flushed the page cache and ran it again, it reported
> different results.
> 
> I concluded it was a rare page cache corruption heisenbug.  Scary.

I can 100% exclude Linux-Errors. The machine (still) runs with Solaris 8.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

