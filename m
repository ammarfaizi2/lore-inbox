Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbREEGmT>; Sat, 5 May 2001 02:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREEGmI>; Sat, 5 May 2001 02:42:08 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:47117 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S132352AbREEGl7>; Sat, 5 May 2001 02:41:59 -0400
Date: Sat, 5 May 2001 03:43:57 -0300
From: John R Lenton <john@grulic.org.ar>
To: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Message-ID: <20010505034357.A604@grulic.org.ar>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela> <3AF2F07E.545BBDDB@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF2F07E.545BBDDB@mail.utexas.edu>; from bdbryant@mail.utexas.edu on Sat, May 05, 2001 at 12:10:06AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2001 at 12:10:06AM +0600, Bobby D. Bryant wrote:
> They do boot PIII kernels reliably for all those variants, though they st=
ill
> suffer occasional oopses, hangs, or crashes (as discussed in other thread=
s).

and as happens with my SMP pIII VIA-based boxed (and I've finally
fixed the memory, so I no longer get the oopses, just solid
hardware hangs).

> However (and here's the part I haven't mentioned before), yesterday I swi=
tched
> one of them to a new mb with a non-VIA chipset (Asus A7A266), and it boot=
ed the
> first Athlon kernel I tried (2.4.4).  No other changes to .config, same
> processor as before, same memory, same disks, same video, same case, same=
 power
> cord, you name it.

damn. I guess the saving of 200$ on the MSI has probably been
300$ down the drain :(

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
If you treat people right they will treat you right -- 90% of the time.
		-- Franklin Delano Roosevelt

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE686EtgPqu395ykGsRApqUAJ9fmKiRnzoTz0DTkevz8CbIomqR7gCfRhxi
YakyNQYOQwgqIBXTA+MkwhQ=
=o0k6
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
