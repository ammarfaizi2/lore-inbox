Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319125AbSHMShJ>; Tue, 13 Aug 2002 14:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319124AbSHMShI>; Tue, 13 Aug 2002 14:37:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55311 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319122AbSHMShH>; Tue, 13 Aug 2002 14:37:07 -0400
Date: Tue, 13 Aug 2002 11:43:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: akpm@zip.com.au, <davem@redhat.com>, <davej@suse.de>,
       <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Network Options and Network Devices together
In-Reply-To: <Pine.LNX.4.33L2.0208131128070.5175-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0208131142200.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Randy.Dunlap wrote:
> 
> This patch to 2.5.31 pushes "Networking options" and
> "Network device support" together for all architectures
> that have them.

Hmm.. There was some reason for doing it this way. I think a number of the 
other options needed to know what teh network config situation was..

		Linus

