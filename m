Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129900AbRB0XRP>; Tue, 27 Feb 2001 18:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129910AbRB0XRH>; Tue, 27 Feb 2001 18:17:07 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:30479 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S129900AbRB0XQx>; Tue, 27 Feb 2001 18:16:53 -0500
Date: Wed, 28 Feb 2001 00:16:23 +0100
From: Kurt Garloff <garloff@suse.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ISO-8859-1 completeness of kernel fonts?
Message-ID: <20010228001623.Q21238@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Guest section DW <dwguest@win.tue.nl>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <F110arjrfh6BYVKBLEB00013ccb@hotmail.com> <3A9BE5F3.780B24AE@transmeta.com> <20010227205837.A18843@win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227205837.A18843@win.tue.nl>; from dwguest@win.tue.nl on Tue, Feb 27, 2001 at 08:58:37PM +0100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2001 at 08:58:37PM +0100, Guest section DW wrote:
> On Tue, Feb 27, 2001 at 09:37:55AM -0800, H. Peter Anvin wrote:
>=20
> > You're much better off designing a larger ISO-8859-1 font and load in in
> > user space.  You can use the 12x22 font in the kernel as a base.
>=20
> kbd-1.05 comes with sun12x22.psfu, which essentially is the kernel font
> together with a unimap.

Note, that I also have a SuSE12x22 font, which is based on the Sun font,
some charcaters slightly changed and added lots of 8859-1 symbols.
Isn't it included in kbd-1.04 and later, Andries?

I also have a patch to make it available for the kernel ...
http://www.garloff.de/kurt/linux/

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nDVGxmLh6hyYd04RArqIAKC+ojQ0WRhnPtvki06pzDhBuUWyqQCgwXXO
4dqqqYy0jD2g+kHq3dUonfM=
=TDge
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--
