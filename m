Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSLWRQA>; Mon, 23 Dec 2002 12:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbSLWRQA>; Mon, 23 Dec 2002 12:16:00 -0500
Received: from splat.lanl.gov ([128.165.17.254]:6293 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S266924AbSLWRP7>; Mon, 23 Dec 2002 12:15:59 -0500
Date: Mon, 23 Dec 2002 10:23:57 -0700
From: Eric Weigle <ehw@lanl.gov>
To: nick@snowman.net
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Sampson Fung <sampson@attglobal.net>, linux-kernel@vger.kernel.org
Subject: Re: OT: Which Gigabit ethernet card?
Message-ID: <20021223172357.GS23388@lanl.gov>
References: <854C62E2-1670-11D7-A27C-000393950CC2@karlsbakk.net> <Pine.LNX.4.21.0212230949270.22216-100000@ns.snowman.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FiqEyLLt06qkB6ow"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0212230949270.22216-100000@ns.snowman.net>
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FiqEyLLt06qkB6ow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > Can I just use a standard Cross Over UTP cable to link up two Intel
> > > Gigabit card, just like Fast Ethernet does?
> > yes, but be careful, as cat 5e is pretty tough when it comes to the=20
> > connector specs
> I belive this is incorrect.  A traditional ethernet crossover crosses two
> pairs, as ethernet & fast ethernet use 2 pairs.  Gigabit ethernet uses all
> 4 pairs, and would need all 4 pairs crossed I assume.
According to spec, maybe, but in practice not necessary. Modern gigE cards
will run just fine over all sorts of pin-outs (even non-crossed over cables)

See=20
http://www.intel.com/network/connectivity/products/pro1000mt_desktop_adapte=
r.htm

"automatically compensates for cable issues such as crossover cable, wrong
pin-out and polarity"

Or
http://www.intel.com/design/network/products/lan/controllers/82546.htm

"PHY detects polarity, MDI-X, 2 pair vs. 4 pair cables, and cable length
=2E.. No need to know the difference between crossover and non-crossover ca=
bles"

-Eric

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--FiqEyLLt06qkB6ow
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+B0at1LDXWFnqnE8RAjDdAKDxsqnAnv94mHGZKkVHAAfY3roDkQCgo4QY
jbF/dLtL3hD4sWni1MiCZfE=
=a0JI
-----END PGP SIGNATURE-----

--FiqEyLLt06qkB6ow--
