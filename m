Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136554AbREEA0Q>; Fri, 4 May 2001 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136579AbREEA0G>; Fri, 4 May 2001 20:26:06 -0400
Received: from ndslppp45.ptld.uswest.net ([63.224.227.45]:50471 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S136554AbREEAZx>;
	Fri, 4 May 2001 20:25:53 -0400
Date: Fri, 4 May 2001 17:26:57 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Aaron Tiensivu <mojomofo@mojomofo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Message-ID: <20010504172657.B14969@debian.org>
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <006e01c0d4e9$3c0bd210$0300a8c0@methusela>; from mojomofo@mojomofo.com on Fri, May 04, 2001 at 06:26:14PM -0400
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2001 at 06:26:14PM -0400, Aaron Tiensivu wrote:
> This might be grasping at straws I remember VIA problem in the "good old
> days" of Socket 7 with CPU/PCI Prefetches and especially Read-around-Write
> settings that would cause issues like we're seeing with the Athlon
> pre-fetches. This could be (total conjecture) related somehow to the
> corruption bugs they are admitting to in the 686B although they are blami=
ng
> the SB Live now.

I don't see how they figure, but in case there was any doubt I have a VIA
KT133A/686B board (Abit KT7A) and don't experience anything resembling
disk corruption unless the box crashes for some other reason.  I do seem
to be experiencing AGP problems in spades, but my disks at least are fine.

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

<_Anarchy_> Argh.. who's handing out the paper bags  8)


--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrzSNEACgkQj/fXo9z52rOUcwCeNW3tJU4/nCmrh4KQlH6X9jWv
paMAoKPE2JTH0RlVp1cfHRfi1oh0C1cx
=AjYi
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
