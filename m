Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSJETSi>; Sat, 5 Oct 2002 15:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbSJETSi>; Sat, 5 Oct 2002 15:18:38 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:34459
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262453AbSJETSh>; Sat, 5 Oct 2002 15:18:37 -0400
Message-ID: <3D9F3C5C.1050708@redhat.com>
Date: Sat, 05 Oct 2002 12:24:12 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <20021004140802.E24148@work.bitmover.com> <20021005175437.GK585@phunnypharm.org> <20021005112552.A9032@work.bitmover.com> <20021005184153.GJ17492@marowsky-bree.de> <20021005190638.GN585@phunnypharm.org>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ben Collins wrote:

> Suddenly all the kernel developers who have staked their work in BK
> cannot work on a "competing" product to BK, without changing their
> development model.

Not only this, it gets worse.

In my case it is almost impossible to not get involved in many many free
software projects.  gettext or i18n in general, of glibc related issues
pop up everywhere and often I contribute patches.  Subversion is one of
the projects where this has been the case in the past.

According to my understanding this means I'm tainted (I've asked Larry
for confirmation).

Now the important part: I still have to work closely with kernel
developers.  The npt work is one example: I had to check out Ingo latest
patches in the kernel every day.  Now this isn't possible anymore without

a) me finding another route to get the latest kernel in realtime (which
still could be considered illegal since somebody else, for the expressed
purpose of making the result available to me, is using bk);

b) the kernel developers I work with not depending on bk anymore.


The second point is what is causing the trouble.  Any team which wants
to use bk to synchronize the work is tainted by one single individual
being tainted.

I have never looked closer at bk than I had to be able to check out the
latest sources.  I'm not doing any development with it and I'm not
checking in anything using bk.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9nzxc2ijCOnn/RHQRAkG5AKCUgMWoYGzb2Hb9kAMHntBLsLXu7ACgyNrA
f2LKpqNQu/nZn4COIBsLWm0=
=WQqn
-----END PGP SIGNATURE-----

