Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbSIZHg7>; Thu, 26 Sep 2002 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbSIZHg7>; Thu, 26 Sep 2002 03:36:59 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:19072 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262228AbSIZHgp>;
	Thu, 26 Sep 2002 03:36:45 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Thu, 26 Sep 2002 00:41:54 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org> <20020926055755.GA5612@think.thunk.org>
In-Reply-To: <20020926055755.GA5612@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209260041.59855.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 25, 2002 22:57, Theodore Ts'o wrote:
> On Wed, Sep 25, 2002 at 10:23:11PM -0700, Ryan Cumming wrote:
> > It seems to be running stable now. Linux 2.4.19, UP Athlon, GCC 3.2.
>
> Just to humor me, can you try it with gcc 2.95.4?  I just want to
> eliminate one variable....

Using GCC 2.95.4 seems to stabilize dir_index nicely, both before and after 
the hdparm -fD run. Only the kernel was recompiled with 2.95.4, I reused the 
original GCC 3.2 compiled e2fsprogs.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9krpHLGMzRzbJfbQRArCGAJ0V8NuAtrUQt/HcOVgbVRtXJzhDwQCeOwtS
Lkkp52o/ku9W4pXoFl8nARc=
=axyt
-----END PGP SIGNATURE-----
