Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261813AbSI2VtS>; Sun, 29 Sep 2002 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261816AbSI2VtS>; Sun, 29 Sep 2002 17:49:18 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:5765 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261813AbSI2VtR>;
	Sun, 29 Sep 2002 17:49:17 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Marc-Christian Petersen <m.c.p@gmx.net>, "Theodore Ts'o" <tytso@mit.edu>,
       "Christopher Li" <chrisl@gnuchina.org>
Subject: Re: ARGS [PATCH] fix htree dir corrupt after fsck -fD
Date: Sun, 29 Sep 2002 14:54:29 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
References: <200209291918.55303.m.c.p@gmx.net>
In-Reply-To: <200209291918.55303.m.c.p@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209291454.33846.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 29, 2002 10:19, Marc-Christian Petersen wrote:
> Hi Ryan,
>
> > I am running your program now over an hour without any corruption on the
> > loopback mounted ext3 filesystem.
>
> shit, I thought testing over an hour (10mins your program, umount, fsck -fD
> test.img in a loop) is enough but it isn't. Damn f*ck :(

Heh, I wonder why it happens faster here. I usually don't umount, and my 
loopback filesystem is small enough that everything fits in RAM. Maybe my 
Athlon XP 1800+ contributes to my computer's raw filesystem corruption power? 
;)

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9l3aZLGMzRzbJfbQRAvGaAJsGG5prZSBAfY8iHjO5iLdb0GJZjACfYQ4k
7t0b05e7JdCglHyL6rd3F2k=
=8q3D
-----END PGP SIGNATURE-----
