Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSIZAb4>; Wed, 25 Sep 2002 20:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSIZAb4>; Wed, 25 Sep 2002 20:31:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18437 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261461AbSIZAbx>;
	Wed, 25 Sep 2002 20:31:53 -0400
Date: Wed, 25 Sep 2002 17:32:52 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Daniel Egger <degger@fhm.edu>
cc: <tytso@mit.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
In-Reply-To: <1032996719.19224.29.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.33L2.0209251732240.29318-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2002, Daniel Egger wrote:

| Am Mit, 2002-09-25 um 22.03 schrieb tytso@mit.edu:
|
| > I've given this code a good bit of testing, under both 2.4 and 2.5
| > kernels, and believe that it is ready for prime-time.  Please pull it
| > from:
|
| > 	bk://extfs.bkbits.net/for-linus-htree-2.5
|
| Where can one fetch the 2.4 code?

As Ted already said:

> Can you post a GNU patch too, for public lookover and independent
> integration?

Sure.  The patch is a bit big for e-mail, but you can find it at:

	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.5.38

There is also a 2.4.19 patch available as well:

	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.4.19-2

-- 
~Randy

