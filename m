Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbSIZGTy>; Thu, 26 Sep 2002 02:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbSIZGTy>; Thu, 26 Sep 2002 02:19:54 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:63360 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262201AbSIZGTy>;
	Thu, 26 Sep 2002 02:19:54 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Wed, 25 Sep 2002 23:25:04 -0700
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
Message-Id: <200209252325.08391.ryan@completely.kicks-ass.org>
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
Before I go again, any suggestions on how to reliably capture these error 
messages? Because the filesystem goes read-only immediately, 
/var/log/messages is hardly useful.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9kqhELGMzRzbJfbQRAkENAJ42ihIhFYwW8+0ssBjgY9OJK4u3nQCeKAz5
RUgZltxYOScsTMG9HwAsdso=
=au0V
-----END PGP SIGNATURE-----
