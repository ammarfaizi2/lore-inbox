Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319124AbSHMSic>; Tue, 13 Aug 2002 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319123AbSHMSib>; Tue, 13 Aug 2002 14:38:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319122AbSHMSib>;
	Tue, 13 Aug 2002 14:38:31 -0400
Date: Tue, 13 Aug 2002 11:39:10 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <akpm@zip.com.au>, <davem@redhat.com>, <davej@suse.de>,
       <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Network Options and Network Devices together
In-Reply-To: <Pine.LNX.4.44.0208131142200.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0208131138390.5175-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Linus Torvalds wrote:

| On Tue, 13 Aug 2002, Randy.Dunlap wrote:
| >
| > This patch to 2.5.31 pushes "Networking options" and
| > "Network device support" together for all architectures
| > that have them.
|
| Hmm.. There was some reason for doing it this way. I think a number of the
| other options needed to know what teh network config situation was..

I actually thought of that, but didn't see it.
I'd be interested in knowing what they are if anyone recalls.

-- 
~Randy

