Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTLKWrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTLKWrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:47:55 -0500
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:52684 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264233AbTLKWry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:47:54 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16344.62465.781288.89878@wombat.chubb.wattle.id.au>
Date: Fri, 12 Dec 2003 09:47:29 +1100
To: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
Cc: "Peter Chubb" <peter@chubb.wattle.id.au>,
       "Hannu Savolainen" <hannu@opensound.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
In-Reply-To: <BAY7-DAV3DOurk9RY0D00008c86@hotmail.com>
References: <16343.60461.218583.753101@wombat.chubb.wattle.id.au>
	<BAY7-DAV3DOurk9RY0D00008c86@hotmail.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jason" == Jason Kingsland <Jason_Kingsland@hotmail.com> writes:

Jason> Hannu Savolainen writes:
>> Even better would be a proper device driver ABI for "loosely
>> integrated" device drivers.

Jason> Peter Chubb writes:

>> One of the things we're working on here is an ABI to allow device
>> drivers to live in user space, by enabling access to interrupts and
>> PCI DMA.

Jason> This is already available via a commercial product.

 ...snip...
Jason> http://www.jungo.com/products.html#driver_tools

Yes I know, I read their web page, and if cross-platform compatibility
is what you want it looks a nice way to go.  They didn't publish any
performance figures (at least, not where I could find), and 
they're binary only, 

There's also the LinuxAnt stuff: http://www.linuxant.com that, for
Wireless cards at least, provides a Windows ABI for standard NDIS
drivers; and Hunt et al's work on Windows 
http://research.microsoft.com/~galenh/Publications/HuntUsenixNt97.pdf


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

