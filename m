Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262541AbSJEUQM>; Sat, 5 Oct 2002 16:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbSJEUQM>; Sat, 5 Oct 2002 16:16:12 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:45979
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262541AbSJEUQK>; Sat, 5 Oct 2002 16:16:10 -0400
Message-ID: <3D9F49D9.304@redhat.com>
Date: Sat, 05 Oct 2002 13:21:45 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <20021004140802.E24148@work.bitmover.com> <20021005175437.GK585@phunnypharm.org> <20021005112552.A9032@work.bitmover.com> <20021005184153.GJ17492@marowsky-bree.de> <20021005190638.GN585@phunnypharm.org> <3D9F3C5C.1050708@redhat.com> <20021005124321.D11375@work.bitmover.com>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Larry McVoy wrote:
>>patches in the kernel every day.  Now this isn't possible anymore without
> 
> 
> Nonsense.  There are all sorts of people who have taken the BK trees and
> made the patch snapshots available on timely basis.

That's not what I was talking about.  It is not possible anymore to use
the same process we did.  It is not possible anymore to react right away
on "Linus checked the patch in; try it.".  It now requires serious
efforts.  And it requires them repeatedly at various sites with people
who have the same problem.  Requiring others to make patch I can apply
does not work since a) it would put extra burden on people who are
already overworked and b) the timezones make it often impossible to get
swift responses.

You mentioned rsync to replicate the archive and then use CSSC.  Would
be fine with me.  But: knowing how to set up rsync would probably
require me to look at all the bk infrastructure and mechanisms more than
I had to do in the whole time I was using bk the check out sources and
while doing this I probably once again violate your license.


And don't get me wrong: you have the right to use whatever license you
want.  I don't complain about that.  I just point out the problem so
that other don't run into the same problems after they started using bk
and in the hope that somebody sets up a service which allows checking
out the current sources in nearly the same time as they are available in
the bk repository without relying on bk (rsync, cvs, subversion, I don't
care how).

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9n0nZ2ijCOnn/RHQRAvDpAJ0ZXkNJKMt+ExMUnwxbOOP9a3xAxgCgwiwX
U+zaoRwM9UVwsJedk/IysVg=
=RTrB
-----END PGP SIGNATURE-----

