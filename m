Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135497AbRDSTzJ>; Thu, 19 Apr 2001 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135511AbRDSTyz>; Thu, 19 Apr 2001 15:54:55 -0400
Received: from hermes.sistina.com ([208.210.145.141]:31757 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S135364AbRDSTxc>;
	Thu, 19 Apr 2001 15:53:32 -0400
Date: Thu, 19 Apr 2001 14:53:37 -0500
From: AJ Lewis <lewis@sistina.com>
To: linux-lvm@sistina.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <jes@linuxcare.com>,
        linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        Arjan van de Ven <arjanv@redhat.com>, Jens Axboe <axboe@suse.de>,
        Martin Kasper Petersen <mkp@linuxcare.com>, riel@conectiva.com.br
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010419145337.K10345@sistina.com>
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nzri8VXeXB/g5ayr"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104191945.f3JJjKRn015661@webber.adilger.int>; from adilger@turbolinux.com on Thu, Apr 19, 2001 at 01:45:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nzri8VXeXB/g5ayr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2001 at 01:45:20PM -0600, Andreas Dilger wrote:
> I don't think that the subscription is necessarily the only issue.  I'm
> subscribed to all of the LVM mailing lists, and still a lot of what I
> submit (legitimate bug fixes, and not just features/code cleanup) does
> not get added to CVS.  Yes, the no-possible-harm patches like man pages
> went in, but not other stuff.  Also, it doesn't appear that any of the
> LVM changes are making it into the stock kernel, which is basically a
> recepie for disaster.

Ok, the issue here is that we're trying to get a release out and so anything
that majorly changes the code is getting shunted aside for the moment.  It
would be stupid to just add everything that comes in on the ML without
review.  Linus does the exact same thing.  I've said this before to you
Andreas, but apparently you feel that you should have final say on whether
your patches go in or not.

As far as getting patches into the stock kernel, we've been sending patches
to Linus for over a month now, and none of them have made it in.  Maybe
someone has some pointers on how we get our code past his filters.

> Basically, I'm at the point where trying to create clean patches from my
> LVM source tree to apply to CVS is so much work it is hardly worth it.
> I'm seriously looking at devoting the time I used to spend on LVM to the
> EVMS project instead.  They (appear to) have in-kernel LVM support working
> already, so no user tools needed for VG/LV activation.  Granted, they don=
't
> yet have tools to create/modify VG/LVs, but I think I can help them there.
> It appears more likely that EVMS will only support Linux LVM volumes for
> compatibility, and move to a more robust on-disk format for metadata.
>
> The openlvm list may change my mind, I'll see.
>=20
> Cheers, Andreas
> --=20
> Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                  \  would they cancel out, leaving him still hungry?"
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
> _______________________________________________
> linux-lvm mailing list
> linux-lvm@sistina.com
> http://lists.sistina.com/mailman/listinfo/linux-lvm

--=20
AJ Lewis
Sistina Software Inc.                  Voice:  612-379-3951
1313 5th St SE, Suite 111              Fax:    612-379-3952
Minneapolis, MN 55414                  E-Mail: lewis@sistina.com
http://www.sistina.com

Current GPG fingerprint =3D 3B5F 6011 5216 76A5 2F6B  52A0 941E 1261 0029 2=
648
Get my key at: http://www.sistina.com/~lewis/gpgkey
 (Unfortunately, the PKS-type keyservers do not work with multiple sub-keys)

-----Begin Obligatory Humorous Quote----------------------------------------
Carpe Aptenodytes! (Seize the Penguins!)
-----End Obligatory Humorous Quote------------------------------------------

--nzri8VXeXB/g5ayr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE630JBpE6/iGtdjLERAkAAAJ4/qd5Y/o5QbTzAtP/oaMpHAS2T0gCePXtX
XU1BNuMA2C7kQ0SfSuk0I+M=
=n6HT
-----END PGP SIGNATURE-----

--nzri8VXeXB/g5ayr--
