Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJAMrx>; Tue, 1 Oct 2002 08:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJAMrx>; Tue, 1 Oct 2002 08:47:53 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:35258 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261584AbSJAMrx>; Tue, 1 Oct 2002 08:47:53 -0400
Date: Tue, 1 Oct 2002 14:53:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.9
In-Reply-To: <200209301914.g8UJEIu154087@saturn.cs.uml.edu>
Message-ID: <Pine.GSO.3.96.1021001144447.13606A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2002, Albert D. Cahalan wrote:

> That's very recent stuff that you sent to the other fork.
> BTW, the /proc/meminfo parsing was cleaned up years ago.
> You didn't see that clean-up because Red Hat fell asleep
> for a few years.

 Well, I don't really use any distribution anymore (although I look at
them for patches from time to time), yet I still believed it's long
abandoned.  A regex search of FTP sites for procps-.*\.tar\.(gz|bz2) 
yields anything from 0.92 up to 2.0.7 but nothing newer and tsx-11 at MIT
still has 2.0.3 only.  It really doesn't hurt to make a release from time
to time if you maintain anything... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

